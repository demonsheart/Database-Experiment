package main

import (
	"database/sql/driver"
	"reflect"
	"time"
)

// https://segmentfault.com/a/1190000022264001

const TimeFormat = "2006-01-02 15:04:05"

type LocalTime time.Time

func (t *LocalTime) UnmarshalJSON(data []byte) (err error) {
	// 空值不进行解析
	if len(data) == 2 {
		*t = LocalTime(time.Time{})
		return
	}

	// 指定解析的格式
	loc, _ := time.LoadLocation("Asia/Shanghai")
	now, err := time.ParseInLocation(`"`+TimeFormat+`"`, string(data), loc)
	*t = LocalTime(now)
	return
}

func (t LocalTime) MarshalJSON() ([]byte, error) {
	b := make([]byte, 0, len(TimeFormat)+2)
	b = append(b, '"')
	b = time.Time(t).AppendFormat(b, TimeFormat)
	b = append(b, '"')
	return b, nil
}

func (t LocalTime) Value() (driver.Value, error) {
	// 0001-01-01 00:00:00 属于空值，遇到空值解析成 null 即可
	if t.String() == "0001-01-01 00:00:00" {
		return nil, nil
	}
	return []byte(time.Time(t).Format(TimeFormat)), nil
}

func (t *LocalTime) Scan(v interface{}) error {
	// mysql 内部日期的格式可能是 2006-01-02 15:04:05 +0800 CST 格式，所以检出的时候还需要进行一次格式化
	tTime, _ := time.Parse("2006-01-02 15:04:05 +0800 CST", v.(time.Time).String())
	*t = LocalTime(tTime)
	return nil
}

// 用于 fmt.Println 和后续验证场景
func (t LocalTime) String() string {
	return time.Time(t).Format(TimeFormat)
}

func ValidateJSONDateType(field reflect.Value) interface{} {
	if field.Type() == reflect.TypeOf(LocalTime{}) {
		timeStr := field.Interface().(LocalTime).String()
		// 0001-01-01 00:00:00 是 go 中 time.Time 类型的空值
		// 这里返回 Nil 则会被 validator 判定为空值，而无法通过 `binding:"required"` 规则
		if timeStr == "0001-01-01 00:00:00" {
			return nil
		}
		return timeStr
	}
	return nil
}

//create table employees
//(
//eid varchar(3) not null,
//ename varchar(15),
//city varchar(15),
//primary key(eid)
//);

type Employees struct {
	Eid   string `gorm:"column:eid;primaryKey" json:"eid" binding:"required"`
	Ename string `gorm:"column:ename" json:"ename" binding:"required"`
	City  string `gorm:"column:city" json:"city" binding:"required"`
}

//
//create table customers
//(
//cid varchar(4) not null,
//cname varchar(15),
//city varchar(15),
//visits_made int(5),
//last_visit_time datetime,
//primary key(cid)
//);

type Customers struct {
	Cid           string    `gorm:"column:cid;primaryKey" json:"cid" binding:"required"`
	Cname         string    `gorm:"column:cname" json:"cname" binding:"required"`
	City          string    `gorm:"column:city" json:"city" binding:"required"`
	VisitsMade    int       `gorm:"column:visits_made;default:1" json:"visits_made"`
	LastVisitTime LocalTime `gorm:"column:last_visit_time;autoUpdateTime" json:"last_visit_time"`
}

//
//create table suppliers
//(
//sid varchar(2) not null,
//sname varchar(15) not null,
//city varchar(15),
//telephone_no char(10),
//primary key(sid),
//unique(sname)
//);

type Suppliers struct {
	Sid         string `gorm:"column:sid;primaryKey" json:"sid" binding:"required"`
	Sname       string `gorm:"column:sname;unique" json:"sname" binding:"required"`
	City        string `gorm:"column:city" json:"city" binding:"required"`
	TelephoneNo string `gorm:"column:telephone_no" json:"telephone_no" binding:"required"`
}

//create table products
//(
//pid varchar(4) not null,
//pname varchar(15) not null,
//qoh int(5) not null,
//qoh_threshold int(5),
//original_price decimal(6,2),
//discnt_rate decimal(3,2),
//sid varchar(2),
//primary key(pid),
//foreign key (sid) references suppliers (sid)
//);

type Products struct {
	Pid           string  `gorm:"column:pid;primaryKey" json:"pid" binding:"required"`
	Pname         string  `gorm:"column:pname;not null" json:"pname" binding:"required"`
	Qoh           int     `gorm:"column:qoh;not null" json:"qoh" binding:"required"`
	QohThreshold  int     `gorm:"column:qoh_threshold;" json:"qoh_threshold" binding:"required"`
	OriginalPrice float32 `gorm:"column:original_price;" json:"original_price" binding:"required"`
	DiscntRate    float32 `gorm:"column:discnt_rate;" json:"discnt_rate" binding:"required"`
	Sid           string  `gorm:"column:sid;" json:"sid" binding:"required"`
	//foreign key (sid) references suppliers (sid)
}

//
//create table purchases
//(
//purid int not null,
//cid varchar(4) not null,
//eid varchar(3) not null,
//pid varchar(4) not null,
//qty int(5),
//ptime datetime,
//total_price decimal(7,2),
//primary key (purid),
//foreign key (cid) references customers(cid),
//foreign key (eid) references employees(eid),
//foreign key (pid) references products(pid)
//);

type Purchases struct {
	Purid      int       `gorm:"column:purid;primaryKey" json:"purid" binding:"required"`
	Cid        string    `gorm:"column:cid;not null" json:"cid" binding:"required"`
	Eid        string    `gorm:"column:eid;not null" json:"eid" binding:"required"`
	Pid        string    `gorm:"column:pid;not null" json:"pid" binding:"required"`
	Qty        int       `gorm:"column:qty;" json:"qty" binding:"required"`
	Ptime      LocalTime `gorm:"column:ptime;autoCreateTime" json:"ptime"`
	TotalPrice float32   `gorm:"column:total_price;" json:"total_price" binding:"required"`
	//foreign key (cid) references customers(cid),
	//foreign key (eid) references employees(eid),
	//foreign key (pid) references products(pid)
}

//
//create table logs
//(
//logid int(5) not null auto_increment,
//who varchar(10) not null,
//time datetime not null,
//table_name varchar(20) not null,
//operation varchar(6) not null,
//key_value varchar(4),
//primary key (logid)
//);

type Logs struct {
	LogId     uint      `gorm:"column:logid;primaryKey;autoIncrement;type:int(5)" json:"log_id"`
	Who       string    `gorm:"column:who;not null" json:"who" binding:"required"`
	Time      LocalTime `gorm:"column:time;not null;autoCreateTime" json:"time"`
	TableName string    `gorm:"column:table_name;not null" json:"table_name" binding:"required"`
	Operation string    `gorm:"column:operation;not null" json:"operation" binding:"required"`
	KeyValue  string    `gorm:"column:key_value" json:"key_value"`
}
