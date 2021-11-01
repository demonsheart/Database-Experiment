package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

/********************************
*         Get Methods          *
*********************************/

func GetTables(c *gin.Context) {
	// select table_name from information_schema.tables where table_schema='my_database' and table_type = 'BASE TABLE';
	var tables []string

	if err := db.Table("information_schema.tables").Select("table_name").Where("table_schema = ? AND table_type = ?", "my_database", "BASE TABLE").Find(&tables).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		fmt.Println(tables)
		c.JSON(200, tables)
	}
}

func GetContents(c *gin.Context) {
	table := c.Param("table")

	switch table {
	case "employees":
		var contents []Employees
		GetContent(contents, c)
	case "customers":
		var contents []Customers
		GetContent(contents, c)
	case "logs":
		var contents []Logs
		GetContent(contents, c)
	case "products":
		var contents []Products
		GetContent(contents, c)
	case "purchases":
		var contents []Purchases
		GetContent(contents, c)
	case "suppliers":
		var contents []Suppliers
		GetContent(contents, c)
	default:
		c.AbortWithStatus(404)
	}

}

func GetContent(contents interface{}, c *gin.Context) {
	if err := db.Find(&contents).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, contents)
	}
}

/********************************
*         Post Methods          *
*********************************/
/*
--- add 捕获了ShouldBindJSON 必须要传binding:"required"才能add
--- delete 和 modify 不捕获ShouldBindJSON 根据RowsAffected判断是否成功
*/

func PostLogs(c *gin.Context) {
	method := c.Param("method")
	var log Logs

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&log); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&log).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "delete":
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
	case "modify":
		c.ShouldBindJSON(&log)
		res := db.Model(&log).Updates(&log)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "modified")
		}
	default:
		c.String(404, "invalid method")
	}
}

func PostPurchases(c *gin.Context) {
	method := c.Param("method")
	var purchase Purchases

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&purchase); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&purchase).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "delete":
		c.ShouldBindJSON(&purchase)
		fmt.Println(purchase)
		res := db.Where("purid = ?", purchase.Purid).Delete(&purchase)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "deleted")
		}
	case "modify":
		c.ShouldBindJSON(&purchase)
		res := db.Model(&purchase).Updates(&purchase)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "modified")
		}
	default:
		c.String(404, "invalid method")
	}
}

func PostProducts(c *gin.Context) {
	method := c.Param("method")
	var product Products

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&product); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&product).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "delete":
		c.ShouldBindJSON(&product)
		fmt.Println(product)
		res := db.Where("pid = ?", product.Pid).Delete(&product)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "deleted")
		}
	case "modify":
		c.ShouldBindJSON(&product)
		res := db.Model(&product).Updates(&product)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "modified")
		}
	default:
		c.String(404, "invalid method")
	}
}

func PostSuppliers(c *gin.Context) {
	method := c.Param("method")
	var supplier Suppliers

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&supplier); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&supplier).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "delete":
		c.ShouldBindJSON(&supplier)
		fmt.Println(supplier)
		res := db.Where("sid = ?", supplier.Sid).Delete(&supplier)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "deleted")
		}
	case "modify":
		c.ShouldBindJSON(&supplier)
		res := db.Model(&supplier).Updates(&supplier)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "modified")
		}
	default:
		c.String(404, "invalid method")
	}
}

func PostCustomers(c *gin.Context) {
	method := c.Param("method")
	var customer Customers

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&customer); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&customer).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "delete":
		c.ShouldBindJSON(&customer)
		fmt.Println(customer)
		res := db.Where("cid = ?", customer.Cid).Delete(&customer)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "deleted")
		}
	case "modify":
		c.ShouldBindJSON(&customer)
		res := db.Model(&customer).Updates(&customer)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "modified")
		}
	default:
		c.String(404, "invalid method")
	}
}

func PostEmployees(c *gin.Context) {
	method := c.Param("method")
	var employee Employees

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&employee); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&employee).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "delete":
		c.ShouldBindJSON(&employee)
		fmt.Println(employee)
		res := db.Where("eid = ?", employee.Eid).Delete(&employee)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "deleted")
		}
	case "modify":
		c.ShouldBindJSON(&employee)
		res := db.Model(&employee).Updates(&employee)
		if res.Error != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": res.Error.Error()})
			return
		}
		if res.RowsAffected == 0 {
			c.String(http.StatusBadRequest, "Affected 0 rows!")
		} else {
			c.String(200, "modified")
		}
	default:
		c.String(404, "invalid method")
	}
}
