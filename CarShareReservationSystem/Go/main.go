package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"github.com/go-playground/validator/v10"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var db *gorm.DB
var err error

func main() {

	username := "go"
	password := "52Swift66@"
	host := "127.0.0.1"
	port := 3306
	Dbname := "CarShare"
	timeout := "10s"

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True&loc=Local&timeout=%s", username, password, host, port, Dbname, timeout)
	db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println(err)
	}

	r := gin.Default()
	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		//注册 LocalTime 类型的自定义校验规则
		v.RegisterCustomTypeFunc(ValidateJSONDateType, LocalTime{})
	}

	// methods
	r.GET("/customers", GetCustomers)
	r.POST("/cars", GetCars)
	r.POST("/customers", PostCustomers)
	r.POST("/probation", GetCusOnProbation)
	r.POST("/passengers", GetNumOfPassengers)
	r.POST("/popular-locations", GetPopularLocations)
	r.POST("/rental-trends", GetRentalTrends)
	r.POST("/increase-price", IncreasePrice)

	_ = r.Run(":60036")
}


