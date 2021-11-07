package main

import (
	"fmt"
	"github.com/gin-gonic/gin/binding"
	"github.com/go-playground/validator/v10"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var db *gorm.DB
var err error

func main() {

	username := "go"
	password := "XUEZHIQIAN"
	host := "127.0.0.1"
	port := 3306
	Dbname := "my_database"
	timeout := "10s"

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local&timeout=%s", username, password, host, port, Dbname, timeout)
	db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println(err)
	}

	//db.AutoMigrate(&Person{})

	r := gin.Default()
	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		// 注册 LocalTime 类型的自定义校验规则
		v.RegisterCustomTypeFunc(ValidateJSONDateType, LocalTime{})
	}

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

	r.Run(":60055")
}
