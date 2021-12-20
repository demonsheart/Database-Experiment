package main

import (
	"errors"
	"github.com/gin-gonic/gin"
	"net/http"
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

	var cars []Car
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

	var cars []Car
	if err := db.Raw("CALL increase_price(?, ?)", params.HourlyIncrease, params.DailyIncrease).Scan(&cars).Error; err != nil {
		c.JSON(200, err)
		return
	}

	c.JSON(200, gin.H{"data": cars})
}
