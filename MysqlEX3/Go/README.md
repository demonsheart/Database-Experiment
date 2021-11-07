## Gin+Gorm编写RESTful API

### 路由与功能对应关系

```go
// get -> select
r.GET("/tables", GetTables)
r.GET("/tables/:table", GetContents)

// :method
r.POST("/tables/employees/:method", PostEmployees)
r.POST("/tables/customers/:method", PostCustomers)
r.POST("/tables/suppliers/:method", PostSuppliers)
r.POST("/tables/products/:method", PostProducts)
r.POST("/tables/purchases/:method", PostPurchases)
r.POST("/tables/logs/:method", PostLogs)
```

> * /tables 列出所有表
>
> * /tables/:table 获取:table表对应的数据内容 对应查询表中所有内容
>
> * /tables/:table/:method 对:table表进行:method，对应增加、删除、修改。



### 模型绑定：为每一个表建立模型结构体(gorm)

以logs表为例子,sql语句如下

```mysql
create table logs
(
    logid int(5) not null auto_increment,
    who varchar(10) not null,
    time datetime not null,
    table_name varchar(20) not null,
    operation varchar(6) not null,
    key_value varchar(4),
    primary key (logid)
);
```

对应Go的struct如下

```go
type Logs struct {
	// old key need to define as pointer type so that we can know if is set by nil.
	OldKeyValue *uint     `gorm:"-" json:"old_key_value,omitempty"`
	LogId       uint      `gorm:"column:logid;primaryKey;autoIncrement;type:int(5)" json:"log_id"`
	Who         string    `gorm:"column:who;not null" json:"who" binding:"required"`
	Time        LocalTime `gorm:"column:time;not null;autoCreateTime" json:"time"`
	TableName   string    `gorm:"column:table_name;not null" json:"table_name" binding:"required"`
	Operation   string    `gorm:"column:operation;not null" json:"operation" binding:"required"`
	KeyValue    string    `gorm:"column:key_value" json:"key_value"`
}
```

> 其中OldKeyValue是以实现主键值更改功能需要添加的字段，后面会详细说明。
> 
> 其它字段与数据表是一一对应关系，gorm指定了与数据表绑定的字段column，以及一些其他的属性，json指定了要传递的json数据的key的值，binding:"required"在gin中绑定验证值非空。

### 功能实现

#### 列出所有表

SQL如下

```mysql
select table_name from information_schema.tables where table_schema='my_database' and table_type = 'BASE TABLE';
```

转换成Go代码如下

```go
var tables []string

db.Table("information_schema.tables").Select("table_name").Where("table_schema = ? AND table_type = ?", "my_database", "BASE TABLE").Find(&tables)
```

> 由于是获取所有表名，定义结果集为[]string一维字符串类型接收结果即可

效果如下：

> GET http://localhost:8080/tables
>
> ___
>
> 
>
> [
>
> ​    "customers",
>
> ​    "employees",
>
> ​    "logs",
>
> ​    "products",
>
> ​    "purchases",
>
> ​    "suppliers"
>
> ]

#### 列出表所有记录(以logs为例)

SQL如下

```mysql
SELECT * FROM `logs`;
```

转换成Go代码如下

```go
var contents []Logs
res = db.Find(&contents)
```

> Logs已经是定义好了的与数据库表一一对应的结构体，字段名、类型信息都在结构体里，只需要调取db.Find()将类型传递进去就可以了。

效果如下：

> GET http://localhost:8080/tables/logs
>
> ___
>
> [
>
> ​    {
>
> ​        "log_id": 6,
>
> ​        "who": "rte",
>
> ​        "time": "2021-11-06 16:07:00",
>
> ​        "table_name": "tret",
>
> ​        "operation": "ret",
>
> ​        "key_value": "te"
>
> ​    }
>
> ]



#### 添加记录(以logs为例)

SQL如下

```mysql
insert into `logs` values (6, 'rte', '2021-11-06 16:07:00', 'tret', 'te');
```

转换成Go代码如下

```go
var log Logs
if err := c.ShouldBindJSON(&log); err != nil {
  c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
  return
}
if err := db.Create(&log).Error; err != nil {
  c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
  return
}
c.String(200, "added")
```

> 首先通过c.ShouldBindJSON(&log)获取到前端传过来的值，并存储到log变量中，再通过调用db.Create(&log)将新的值插入进去即可

效果如下：

> POST http://localhost:8080/tables/logs/add
>
> {
>     "log_id": 6,
>     "who": "rte",
>     "time": "2021-11-06 16:07:00",
>     "table_name": "tret",
>     "operation": "ret",
>     "key_value": "te"
> }
>
> ___
>
> added



#### 修改记录(以logs为例)

SQL如下

```mysql
# 主键没有改变的情况
update `logs` set `log_id` = 6, `who` = 'uuu', `time` = '2021-11-06 16:07:00', `table_name` = 'rr', `operation` = 'gg', `key_value` = 'te'
where `log_id` = 6;

# 主键改变的情况 需要old_key_value保存旧的主键值
update `logs` set `log_id` = 7, `who` = 'uuu', `time` = '2021-11-06 16:07:00', `table_name` = 'rr', `operation` = 'gg', `key_value` = 'te'
where `old_key_value` = 6;
```

转换成Go代码如下

```go
var log Logs
c.ShouldBindJSON(&log)
var res *gorm.DB
if log.OldKeyValue == nil {
  res = db.Model(Logs{}).Where("logid = ?", log.LogId).Updates(&log)
} else {
  // need to update key
  res = db.Model(Logs{}).Where("logid = ?", *log.OldKeyValue).Updates(&log)
}
if res.Error != nil {
  c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
  return
}
if res.RowsAffected == 0 {
  c.String(http.StatusBadRequest, "Affected 0 rows!")
} else {
  c.String(200, "modified")
}
```

> 首先通过c.ShouldBindJSON(&log)获取前端传过来的值，然后通过log.OldKeyValue是否被设置判断是否需要修改主键的值：
>
> * 不需要修改主键的值的情况：**Where("logid = ?", log.LogId)**，通过log.LogId指定记录
> * 需要修改主键的情况：**Where("logid = ?", *log.OldKeyValue)**，通过log.OldKeyValue指定记录
> * 其中log.OldKeyValue在模型定义时指定为指针类型，就可以通过log.OldKeyValue == nil判断前端是否有传OldKeyValue进来。

效果如下：

> POST http://localhost:8080/tables/logs/modify
>
> {
>     "log_id": 6,
>     "who": "uuu",
>     "time": "2021-11-06 16:07:00",
>     "table_name": "rr",
>     "operation": "gg",
>     "key_value": "te"
> }
>
> ___
>
> modified



#### 删除记录(以logs为例)

SQL如下：

```mysql
DELETE FROM `logs` WHERE `logid` = 1;
```

转化为Go代码如下：

```go
var log Logs
c.ShouldBindJSON(&log)
fmt.Println(log)
res := db.Where("logid = ?", log.LogId).Delete(&log)
if res.Error != nil {
  c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
  return
}
if res.RowsAffected == 0 {
  c.String(http.StatusBadRequest, "Affected 0 rows!")
} else {
  c.String(200, "deleted")
}
```

> 核心就是db.Where("logid = ?", log.LogId).Delete(&log)，通过logid定位记录并删除

效果如下：

> POST http://localhost:8080/tables/logs/delete
>
> {
>     "log_id": 1
> }
>
> ___
>
> deleted



### 踩过的坑和一些细节之处

1. Go时间处理格式化问题 

   > 主要根据[这篇文章](https://segmentfault.com/a/1190000022264001)自定义结构体以及重写接口解决

2. 主键改变了需要旧主键的信息，但这是一个可选值，结构体中定义如下

   ```go
   OldKeyValue *int      `gorm:"-" json:"old_key_value,omitempty"`
   ```

   > 这里有三个关键点：
   >
   > 1. omitempty关键字，golang在处理json转换时，对于标签omitempty定义的field，如果给它赋得值恰好等于空值（比如：false、0、""、nil指针、nil接口、长度为0的数组、切片、映射），则在转为json之后不会输出这个field。
   > 2. 定义为指针类型，而不是值类型，配合omitempty关键字，可在前端无传递值的时候通过指针类型的nil值判断(而不是值类型的0，0值在此并不可靠，比如说刚好传了个0过来的情况)。
   > 3. gorm:"-"忽略绑定到数据表。

   

