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
	r.POST("/login", Login) // 登录
	r.POST("/register", Register) // 注册
	r.POST("/is-id-register", IsIdRegister) // id是否已注册
	r.POST("/is-phone-register", IsPhoneRegister) // 手机是否已注册
	r.POST("/rent-car", RentCar) // 租车
	r.POST("/cars", GetCars) // 展示车型
	r.POST("/probation", GetCusOnProbation) // 试用期客户
	r.POST("/passengers", GetNumOfPassengers)// 根据人数返回合适的汽车
	r.POST("/popular-locations", GetPopularLocations) // 热门地点
	r.POST("/rental-trends", GetRentalTrends) // 租车趋势
	r.POST("/increase-price", IncreasePrice) // 增加价格
	r.POST("/validate-rent", ValidateRent) // 验证租车日期的有效性
	r.GET("/center-loc", GetCenters) // 获取地点中心
	r.POST("/get-rentals", GetRentals) // 获取个人租车信息

	_ = r.Run(":60036")
}





