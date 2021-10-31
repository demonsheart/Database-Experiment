package main

import (
	"time"
)

//create table employees
//(
//eid varchar(3) not null,
//ename varchar(15),
//city varchar(15),
//primary key(eid)
//);

type Employee struct {
	Eid   string `gorm:"primaryKey" json:"eid"`
	Ename string `json:"ename"`
	City  string `json:"city"`
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
	Cid           string    `gorm:"primaryKey" json:"cid"`
	Cname         string    `json:"cname"`
	City          string    `json:"city"`
	VisitsMade    int       `json:"visits_made"`
	LastVisitTime time.Time `json:"last_visit_time"`
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
	Sid         string `gorm:"primaryKey" json:"sid"`
	Sname       string `gorm:"unique" json:"sname"`
	City        string `json:"city"`
	TelephoneNo string `json:"telephone_no"`
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
	Pid           string  `gorm:"primaryKey" json:"pid"`
	Pname         string  `gorm:"not null" json:"pname"`
	Qoh           int     `gorm:"not null" json:"qoh"`
	QohThreshold  int     `json:"qoh_threshold"`
	OriginalPrice float32 `json:"original_price"`
	DiscntRate    float32 `json:"discnt_rate"`
	Sid           string  `json:"sid"`
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
	Purid      int       `gorm:"primaryKey" json:"purid"`
	Cid        string    `gorm:"not null" json:"cid"`
	Eid        string    `gorm:"not null" json:"eid"`
	Pid        string    `gorm:"not null" json:"pid"`
	Qty        int       `json:"qty"`
	Ptime      time.Time `json:"ptime"`
	TotalPrice float32   `json:"total_price"`
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
	LogId     int       `gorm:"primaryKey;autoIncrement" json:"log_id"`
	Who       string    `gorm:"not null" json:"who"`
	Time      time.Time `gorm:"not null" json:"time"`
	TableName string    `gorm:"not null" json:"table_name"`
	Operation string    `gorm:"not null" json:"operation"`
	KeyValue  string    `json:"key_value"`
}
