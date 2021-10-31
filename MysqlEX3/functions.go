package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

/********************************
*         Get Methods          *
*********************************/

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
	var tables []string

	if err := db.Table("information_schema.tables").Select("table_name").Where("table_schema = ? AND table_type = ?", "my_database", "BASE TABLE").Find(&tables).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		fmt.Println(tables)
		c.JSON(200, tables)
	}
}

/********************************
*         Post Methods          *
*********************************/

func PostLogs(c *gin.Context) {
	method := c.Param("method")
	var log Logs
	if err := c.ShouldBindJSON(&log); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	fmt.Println(log)
	switch method {
	case "add":
		db.Create(&log)
		c.String(200, method)
	case "delete":
		c.String(200, method)
	case "modify":
		c.String(200, method)
	default:
		c.String(404,"invalid method")
	}
}

func PostPurchases(c *gin.Context) {
	method := c.Param("method")
	switch method {
	case "add":
		c.String(200, method)
	case "delete":
		c.String(200, method)
	case "modify":
		c.String(200, method)
	default:
		c.String(404,"invalid method")
	}
}

func PostProducts(c *gin.Context) {
	method := c.Param("method")
	switch method {
	case "add":
		c.String(200, method)
	case "delete":
		c.String(200, method)
	case "modify":
		c.String(200, method)
	default:
		c.String(404,"invalid method")
	}
}

func PostSuppliers(c *gin.Context) {
	method := c.Param("method")
	switch method {
	case "add":
		c.String(200, method)
	case "delete":
		c.String(200, method)
	case "modify":
		c.String(200, method)
	default:
		c.String(404,"invalid method")
	}
}

func PostCustomers(c *gin.Context) {
	method := c.Param("method")
	switch method {
	case "add":
		c.String(200, method)
	case "delete":
		c.String(200, method)
	case "modify":
		c.String(200, method)
	default:
		c.String(404,"invalid method")
	}
}

func PostEmployees(c *gin.Context) {
	method := c.Param("method")
	switch method {
	case "add":
		c.String(200, method)
	case "delete":
		c.String(200, method)
	case "modify":
		c.String(200, method)
	default:
		c.String(404,"invalid method")
	}
}