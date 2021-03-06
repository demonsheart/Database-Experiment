#### 实施汽车共享订阅系统

在本例中，您将为汽车共享业务设计一个关系数据库。在您的数据库设计完成并正确后，您将创建数据库表并用数据填充它们。客户将在您的网站上订阅和挑选汽车。因此，您将制作网站，该网站将展示一个出租的汽车以及一些查询报告。您将生成一个带有子表单、五个查询、五个查询和报告和报告。一个自定义导航车辆的查询表单。该表格将记录每辆汽车的汽车租赁情况。另外一个将允许查询车辆的汽车租赁趋势。公司提高其车辆的租赁价格。该报告将总结本月客户的租赁价格，以及向客户收取的费用。自定义导航运营将允许访问所有表格、表单、查询和报告。需要一个使用PHP实现的Web交互界面，以确保您的系统用户可以方便地使用您的项目。

 

#### 背景

Atlanta Car Share (ACS) 是一家按小时或按天向汽车出租的公司。模型很简单：客户注册服务，在网上订阅，然后从城市的三个区域取车。他们获得了密码，可以打开一个中央吊舱，在那里他们可以找到汽车的钥匙。这至少有足够的汽油和信用卡信用卡，以便进一步加满油。因此，共享汽车的费用包括使用的汽油。共享汽车的起价为 3.90 美元和每天 39.00 美元。价格还包括汽车保险。

您受雇为ACS创建订阅数据库时，您必须牢记几个参数。潜在客户在注册ACS时，需要提供一定数量的，并注明是否是学生。需要信息包括全名、地址。 、电话号码、手机号码、电子邮件和信用卡信息。需要披露他们驾驶中的信息记录。

ACS有多种汽车地点共享。汽车因品牌、型号和租赁而异。客户通常希望尺寸搜索汽车，因此请注意选择适合地装汽车价格的最大人群。ACS有三个中央位置可供选择。汽车。当客户订阅汽车时，他们会记下取车和还车的位置代码。有一个带有子表单的表单来记录客户订阅会很方便。

ACS管理层希望列出过去三年内有违规行为（例如闯红灯）的学生客户。这些客户将被置于试用期，这是一个比平时更密切地观察他们在共享汽车中的驾驶习惯的时期。查询可以提供此列表。

客户经常打电话给ACS的总公司，想知道一辆汽车能容纳多少乘客。管理层希望您设置查询来回答该问题。查询将提示用户输入所需的乘客数量，输出将显示所有可以处理该数量的车辆。

ACS 未来希望做一些分析来规划未来的目标。首先，他们希望您创建一个，未来的汽车取货地点。他们数据某个地点是客户最喜欢的，但他们想知道这一个怀疑。此外，他们想知道哪些类型的客户正在共享哪些类型的汽车。特别是，他们希望将数据分为学生组和非学生组。

最近燃料成本飞涨，因此ACS想将共享所有车辆的价格提高每小时0.50美元和每天5.00美元。ACS希望您创建更新查询以提高价格。管理层喜欢获得显示公司经营状况的定期报告。您需要为当月创建一份报告，显示租金预订和每个预订的潜在收入。最后，应在网站上设置自定义导航窗格，以便轻松处理数据库

#####  1.建立数据库（15分）

使用SQL DDL 创建创建此项目所需的表。还请注意，表是更具体的创建的，这样在需要创建外键的时候，也需要创建相应的主键。

1. 首先，通过在纸上列出它们来确定您需要的表格。列出每个表的名称和它应该包含的字段。避免数据冗余。如果可以通过以下方式创建字段，则不要创建字段查询中的“计算结果”。

2. 您将需要交易（租赁）。考虑表客户的交易会发生哪些业务事件。避免重复数据。

3. 你必须为每个表标记适当的主键字段或外键字段。请记住，每个表都需要一个复合主键来唯一标识表中的记录。

4. 不同厂家、不同人群的汽车最少输入10条记录。

5. 输入至少10个客户的记录，包括他们的姓名、地址、电话号码、电子邮件地址等。输入您自己的姓名和信息作为附加客户。

6. 每一段文字应该至少租用一次。客户应该租用一版。文本限制场景的大小；例如，电话号码不需要 255 个字符的默认长度。

 

##### 2.MySQL实现（55分） 

您需要 SQL 查询、存储过程/函数和功能来实现该项目。需要实现以下要求和功能。

1. （8分）编写一个名为“试用期客户”的存储过程，用于过滤所有在过去三年内有过门票的学生客户。查询应包括姓氏，名字和电子邮件地址的列。根据数据，查询输出可能非表1中的输出。

表1 试用期客户 Customers on Probation

| **Customers on Probation** |                |                   |
| -------------------------- | -------------- | ----------------- |
| **Last Name**              | **First Name** | **Email Address** |
| Murray                     | Annabelle      | belle@comcast.net |
| Quinn                      | Sean           | quinn45@gmail.com |
| Smith                      | Patricia       | patti1@gmail.com  |

 

2. （9分）写一个不知道乘客人数的过程。此应提示用户输入共享汽车的乘客人数。查询应显示、制造、型号、每小时价格和乘客人数的列。乘客人数应符合规定的人数要求。您的数据会有所不同，但如果您输入四个或更多所需乘客的数据，您的输出应与表2中的类似。

表 2乘客人数  Number of Passengers

| **Number of Passengers** |          |                 |                    |                          |
| ------------------------ | -------- | --------------- | ------------------ | ------------------------ |
| **Car ID**               | **Make** | **Model**       | **Price Per Hour** | **Number of Passengers** |
| 101                      | Subaru   | Impreza         | $3.90              | 5                        |
| 102                      | Lexus    | IS250           | $5.00              | 5                        |
| 104                      | Toyota   | Prius  Liftback | $5.50              | 5                        |
| 105                      | Honda    | Element         | $3.90              | 5                        |




3. （12分）写一个热门地点的存储过程。使用查询的功能，确定每个位置发生了多少次租赁。查询包括位置ID、街道地址、电话和租赁数量的列。请注意，列标题与查询生成器提供的默认设置不同。您的数据会有所不同，但应输出数据表 3 中的。

表3重点地点  Popular Locations

| **Popular Locations** |                      |               |                       |
| --------------------- | -------------------- | ------------- | --------------------- |
| **Location ID**       | **Street   Address** | **Telephone** | **Number of Rentals** |
| 60                    | 800  Cherokee Drive  | 404-776-1022  | 8                     |
| 59                    | 1400 W  Peachtree NE | 404-897-0021  | 2                     |
| 61                    | 2238 Perkerson Road  | 404-223-1056  | 1                     |

  

4. (12 分) 写一个名为租赁趋势的存储过程。同样，使用查询的功能，确定每个模型的租用次数。查询包括制作、模型、学生？和租金次数数列。按学生对查询进行排序。请注意，列标题与查询生成器提供的默认设置不同。您的输出应该类似于表4的中输出，但具有不同的数据。

表 4 租赁倾向 Rental Trends

| **Make** | **Model**      | **Student?** | **Number of Times Rented** |
| -------- | -------------- | ------------ | -------------------------- |
| Lexus    | IS250          | yes          | 2                          |
| Smart    | Passion        | yes          | 2                          |
| Subaru   | Impreza        | yes          | 1                          |
| Honda    | Element        | no           | 2                          |
| Subaru   | Impreza        | no           | 3                          |
| Toyota   | Prius Liftback | No           | 1                          |



5. （14 分）创建一个不计“增加的价格”的更新，该为每月租金价格增加 0.50 美元，为每美元租金价格每天增加 5.00 美元。运行以对其进行查询查询。

 

##### 3.接口（20分）

使用PHP 、JavaScript等实现Web交互界面。你的接口程序实用多地使用你的MySQL存储过程/函数。

 

##### 4. 文档（10分）

文档包括以下几个方面：

1. 你为项目每个细节的过程和功能以及其他每个对象都需要清楚地解释其目标和用途。

2. 您的代码需要使用内嵌注释进行详细记录。

 

##### 5.上手、演示和评分

1. 您还需要将源代码和文档一起提交到 Blackboard。
2. 需要使用教师创建的元组向教师演示您的项目。
3. 评分将基于您的代码质量、文档以及演示的成功程度。

 