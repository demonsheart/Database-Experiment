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
	Eid   string `gorm:"primaryKey" json:"eid" binding:"required"`
	Ename string `json:"ename" binding:"required"`
	City  string `json:"city" binding:"required"`
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
	Cid           string    `gorm:"primaryKey" json:"cid" binding:"required"`
	Cname         string    `json:"cname" binding:"required"`
	City          string    `json:"city" binding:"required"`
	VisitsMade    int       `json:"visits_made" binding:"required"`
	LastVisitTime time.Time `json:"last_visit_time" binding:"required"`
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
	Sid         string `gorm:"primaryKey" json:"sid" binding:"required"`
	Sname       string `gorm:"unique" json:"sname" binding:"required"`
	City        string `json:"city" binding:"required"`
	TelephoneNo string `json:"telephone_no" binding:"required"`
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
	Pid           string  `gorm:"primaryKey" json:"pid" binding:"required"`
	Pname         string  `gorm:"not null" json:"pname" binding:"required"`
	Qoh           int     `gorm:"not null" json:"qoh" binding:"required"`
	QohThreshold  int     `json:"qoh_threshold" binding:"required"`
	OriginalPrice float32 `json:"original_price" binding:"required"`
	DiscntRate    float32 `json:"discnt_rate" binding:"required"`
	Sid           string  `json:"sid" binding:"required"`
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
	Purid      int       `gorm:"primaryKey" json:"purid" binding:"required"`
	Cid        string    `gorm:"not null" json:"cid" binding:"required"`
	Eid        string    `gorm:"not null" json:"eid" binding:"required"`
	Pid        string    `gorm:"not null" json:"pid" binding:"required"`
	Qty        int       `json:"qty" binding:"required"`
	Ptime      time.Time `json:"ptime" binding:"required"`
	TotalPrice float32   `json:"total_price" binding:"required"`
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
	Who       string    `gorm:"not null" json:"who" binding:"required"`
	Time      time.Time `gorm:"not null" json:"time" binding:"required"`
	TableName string    `gorm:"not null" json:"table_name" binding:"required"`
	Operation string    `gorm:"not null" json:"operation" binding:"required"`
	KeyValue  string    `json:"key_value" binding:"required"`
}
