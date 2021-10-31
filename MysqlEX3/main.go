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
	r.GET("/tables/customers", GetCustomers)
	r.GET("/tables/suppliers", GetSuppliers)
	r.GET("/tables/products", GetProducts)
	r.GET("/tables/purchases", GetPurchases)
	r.GET("/tables/logs", GetLogs)

	r.Run(":8080")
}

func GetLogs(c *gin.Context) {
	var contents []Logs

	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

func GetPurchases(c *gin.Context) {
	var contents []Purchases

	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

func GetProducts(c *gin.Context) {
	var contents []Products

	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

func GetSuppliers(c *gin.Context) {
	var contents []Suppliers

	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

func GetCustomers(c *gin.Context) {
	var contents []Customers

	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

func GetEmployees(c *gin.Context) {
	var contents []Employee

	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

func GetTables(c *gin.Context) {
	// select table_name from information_schema.tables where table_schema='my_database';
	tables := []string{}

	if err := db.Table("information_schema.tables").Select("table_name").Where("table_schema = ?", "my_database").Find(&tables).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		fmt.Println(tables)
		c.JSON(200, tables)
	}
}
