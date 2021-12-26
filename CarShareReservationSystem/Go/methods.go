package main

import (
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"net/http"
	"time"
)

func MyHeaderValidate(c *gin.Context) error {
	h := MyHeader{}
	if err := c.ShouldBindHeader(&h); err != nil {
		return err
	}

	if h.UserAgent != "HRJ" {
		return errors.New("invalid UA")
	}

	return nil
}

// GetCusOnProbation  试用期客户
func GetCusOnProbation(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var probationUsers []Probation
	if err := db.Raw("CALL cus_on_probation()").Scan(&probationUsers).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": probationUsers})
}

// GetNumOfPassengers 根据乘客数返回车辆
func GetNumOfPassengers(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var params NumOfPassengersParams
	if err := c.ShouldBindJSON(&params); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var cars []Cars
	if err := db.Raw("CALL number_of_passengers(?)", params.Num).Scan(&cars).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": cars})
}

// GetPopularLocations 热门位置
func GetPopularLocations(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var popularLocs []PopularLoc
	if err := db.Raw("CALL popular_locations()").Scan(&popularLocs).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": popularLocs})
}

// GetRentalTrends 租赁趋势
func GetRentalTrends(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var rentalTrend []RentalTrend
	if err := db.Raw("CALL rental_trends()").Scan(&rentalTrend).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": rentalTrend})
}

// IncreasePrice 提升价格 可以填负数减少
func IncreasePrice(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var params IncreasePriceParams
	if err := c.ShouldBindJSON(&params); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var cars []Cars
	if err := db.Raw("CALL increase_price(?, ?)", params.HourlyIncrease, params.DailyIncrease).Scan(&cars).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": cars})
}

func GetCustomers(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var cus []Customers
	if err := db.Find(&cus).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, gin.H{"data": cus})
	}
}

func PostCustomers(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	method := c.Param("method")
	var cus Customers

	switch method {
	case "add":
		if err := c.ShouldBindJSON(&cus); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&cus).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		c.String(200, "added")
	case "modify":
		_ = c.ShouldBindJSON(&cus)
		var res *gorm.DB
		if cus.OldKeyValue == nil {
			res = db.Model(Customers{}).Where("cus_id = ?", cus.CusID).Updates(&cus)
		} else {
			// need to update key
			res = db.Model(Customers{}).Where("cus_id = ?", *cus.OldKeyValue).Updates(&cus)
		}
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

func GetCars(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var car []Cars
	if err := db.Find(&car).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, gin.H{"data": car})
	}
}

func Login(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	// bind params
	var params LoginParams
	if err := c.ShouldBindJSON(&params); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// find user
	var userMessage Customers
	var re *gorm.DB
	re = db.Model(Customers{}).
		Where("cus_id = ? AND password = ?", params.CusID, params.Password).
		First(&userMessage)

	if re.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false,"error": re.Error.Error()})
		return
	}

	// return res
	userMessage.Password = "" // not need pw
	c.JSON(200, gin.H{"success": true, "data": userMessage})
}

func Register(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var cus Customers
	if err := c.ShouldBindJSON(&cus); err != nil {
		c.JSON(200, gin.H{"success": false, "error": err.Error()})
		return
	}
	if err := db.Create(&cus).Error; err != nil {
		c.JSON(200, gin.H{"success": false, "error": err.Error()})
		return
	}
	println("true")
	c.JSON(200, gin.H{"success": true, "error": ""})
}

// IsIdRegister 判断是否被注册(account is unique)
func IsIdRegister(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}
	var account IsIDRegister
	var cus Customers
	err1 := c.ShouldBindJSON(&account)

	if err1 == nil { // account
		if err := db.Model(Customers{}).Where(Customers{CusID: account.CusID}).First(&cus).Error; errors.Is(err, gorm.ErrRecordNotFound) {
			c.JSON(200, gin.H{"success": true, "error": ""})
			return
		}
	}
	c.JSON(200, gin.H{"success": false, "error": "not valid params"})
	return
}

// IsPhoneRegister 判断是否被注册(cell_phone is unique)
func IsPhoneRegister(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}
	var cell IsCellPhoneRegister
	var cus Customers
	err1 := c.ShouldBindJSON(&cell)

	if err1 == nil { // account
		if err := db.Model(Customers{}).Where(Customers{CellPhone: cell.CellPhone}).First(&cus).Error; errors.Is(err, gorm.ErrRecordNotFound) {
			c.JSON(200, gin.H{"success": true, "error": ""})
			return
		}
	}
	c.JSON(http.StatusBadRequest, gin.H{"success": false, "error": "not valid params"})
	return
}

func RentCar(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var rent Rental
	if err := c.ShouldBindJSON(&rent); err != nil {
		c.JSON(200, gin.H{"success": false, "error": err.Error()})
		return
	}

	// validate
	valid, mess := validateRentTime(rent)
	if !valid {
		c.JSON(200, gin.H{"success": valid, "error": mess})
		return
	}

	//insert
	// 主键由数据库触发器
	rent.RentalId = "#"
	if err := db.Create(&rent).Error; err != nil {
		c.JSON(200, gin.H{"success": false, "error": err.Error()})
		return
	}

	c.JSON(200, gin.H{"success": true, "error": ""})
}

func ValidateRent(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var rent Rental
	if err := c.ShouldBindJSON(&rent); err != nil {
		c.JSON(200, gin.H{"success": false, "error": err.Error()})
		return
	}

	// validate
	valid, mess := validateRentTime(rent)
	c.JSON(200, gin.H{"success": valid, "error": mess})
}

func validateRentTime(rent Rental) (bool, string) {
	var rentsForCar []Rental
	var res string
	var valid bool = true

	if err := db.Model(Rental{}).Where(Rental{CarID: rent.CarID}).Find(&rentsForCar).Error; err != nil {
		return false, "Server Fail"
	}

	// time validate
	if myAfter(rent.StartTime, rent.EndTime) || rent.StartTime.String() == rent.EndTime.String() {
		return false, "StartTime must less than endTime"
	}

	for _, v := range rentsForCar {
		fmt.Println(*v.CarID, " ", v.StartTime, " ", v.EndTime)

		judge1 := myAfter(rent.StartTime, v.StartTime) && myBefore(rent.StartTime, v.EndTime)
		judge2 := myAfter(rent.EndTime, v.StartTime) && myBefore(rent.EndTime, v.EndTime)
		judge3 := myBefore(rent.StartTime, v.StartTime) && myAfter(rent.EndTime, v.EndTime)

		if judge1 && judge2 {
			valid = false
			res = "This period has been fully occupied"
			break
		}

		if judge1 {
			valid = false
			res = "You might try to rent after " + v.EndTime.String()
			break
		}

		if judge2 {
			valid = false
			res = "You might try to rent before " + v.StartTime.String()
			break
		}

		if judge3 {
			valid = false
			res = "You need to end before " + v.StartTime.String() + " or start after " + v.EndTime.String()
			break;
		}
	}

	return valid, res
}

func myBefore(t1 LocalTime, t2 LocalTime) bool {
	timeLayout := "2006-01-02 15:04:05"
	location, _ := time.LoadLocation("Local") // timeStr是北京时间，注意使用Local
	tt1, _ := time.ParseInLocation(timeLayout, t1.String(), location)
	tt2, _ := time.ParseInLocation(timeLayout, t2.String(), location)

	return tt1.Before(tt2) || tt1.Equal(tt2)
}

func myAfter(t1 LocalTime, t2 LocalTime) bool {
	timeLayout := "2006-01-02 15:04:05"
	location, _ := time.LoadLocation("Local") // timeStr是北京时间，注意使用Local
	tt1, _ := time.ParseInLocation(timeLayout, t1.String(), location)
	tt2, _ := time.ParseInLocation(timeLayout, t2.String(), location)

	return tt1.After(tt2) || tt1.Equal(tt2)
}

func GetCenters(c *gin.Context) {
	if err := MyHeaderValidate(c); err != nil {
		c.AbortWithStatus(404)
		return
	}

	var locs []ACSCenter
	if err := db.Model(ACSCenter{}).Find(&locs).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": locs})
}
