package main

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var db *gorm.DB
var err error

func main() {

	username := "php"
	password := "xuezhiqian"
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

	r.GET("/tables", GetTables)
	r.GET("/tables/employees", GetEmployees)
	r.POST("/tables/employees/:method", PostEmployees)
	r.GET("/tables/customers", GetCustomers)
	r.POST("/tables/customers/:method", PostCustomers)
	r.GET("/tables/suppliers", GetSuppliers)
	r.POST("/tables/suppliers/:method", PostSuppliers)
	r.GET("/tables/products", GetProducts)
	r.POST("/tables/products/:method", PostProducts)
	r.GET("/tables/purchases", GetPurchases)
	r.POST("/tables/purchases/:method", PostPurchases)
	r.GET("/tables/logs", GetLogs)
	r.POST("/tables/logs/:method", PostLogs)

	r.Run(":8080")
}
