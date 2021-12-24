package main

import (
	"database/sql/driver"
	"reflect"
	"time"
)

// https://segmentfault.com/a/1190000022264001

const TimeFormat = "2006-01-02 15:04:05"

type LocalTime time.Time

func (t *LocalTime) UnmarshalJSON(data []byte) (err error) {
	// 空值不进行解析
	if len(data) == 2 {
		*t = LocalTime(time.Time{})
		return
	}

	// 指定解析的格式
	loc, _ := time.LoadLocation("Asia/Shanghai")
	now, err := time.ParseInLocation(`"`+TimeFormat+`"`, string(data), loc)
	*t = LocalTime(now)
	return
}

func (t LocalTime) MarshalJSON() ([]byte, error) {
	b := make([]byte, 0, len(TimeFormat)+2)
	b = append(b, '"')
	b = time.Time(t).AppendFormat(b, TimeFormat)
	b = append(b, '"')
	return b, nil
}

func (t LocalTime) Value() (driver.Value, error) {
	// 0001-01-01 00:00:00 属于空值，遇到空值解析成 null 即可
	if t.String() == "0001-01-01 00:00:00" {
		return nil, nil
	}
	return []byte(time.Time(t).Format(TimeFormat)), nil
}

func (t *LocalTime) Scan(v interface{}) error {
	// mysql 内部日期的格式可能是 2006-01-02 15:04:05 +0800 CST 格式，所以检出的时候还需要进行一次格式化
	tTime, _ := time.Parse("2006-01-02 15:04:05 +0800 CST", v.(time.Time).String())
	*t = LocalTime(tTime)
	return nil
}

// 用于 fmt.Println 和后续验证场景
func (t LocalTime) String() string {
	return time.Time(t).Format(TimeFormat)
}

func ValidateJSONDateType(field reflect.Value) interface{} {
	if field.Type() == reflect.TypeOf(LocalTime{}) {
		timeStr := field.Interface().(LocalTime).String()
		// 0001-01-01 00:00:00 是 go 中 time.Time 类型的空值
		// 这里返回 Nil 则会被 validator 判定为空值，而无法通过 `binding:"required"` 规则
		if timeStr == "0001-01-01 00:00:00" {
			return nil
		}
		return timeStr
	}
	return nil
}

// MyHeader 个人验证
type MyHeader struct {
	UserAgent string `header:"User-Agent"`
}

// Probation 试用期客户
type Probation struct {
	LastName  string `gorm:"column:last_name" json:"last_name"`
	FirstName string `gorm:"column:first_name" json:"first_name"`
	Email     string `gorm:"column:email" json:"email"`
}

// NumOfPassengersParams 乘客数参数
type NumOfPassengersParams struct {
	Num int `binding:"required" json:"num"`
}

// Cars 根据乘客数参数返回的车类型
type Cars struct {
	CarID        int     `gorm:"column:car_id" json:"car_id"`
	Make         string  `gorm:"column:make" json:"make"`
	Model        string  `gorm:"column:model" json:"model"`
	PricePerHour float32 `gorm:"column:price_per_hour" json:"price_per_hour"`
	PricePerDay  float32 `gorm:"column:price_per_day" json:"price_per_day"`
	Capacity     int     `gorm:"column:capacity" json:"capacity"`
	PicUrl       string  `gorm:"column:pic_url" json:"pic_url"`
}

// PopularLoc 热门位置
type PopularLoc struct {
	LocID           int    `gorm:"column:loc_id" json:"loc_id"`
	StreetAddress   string `gorm:"column:street_address" json:"street_address"`
	TelephoneNumber string `gorm:"column:telephone_number" json:"telephone_number"`
	NumberOfRentals int    `gorm:"column:number_of_rentals" json:"number_of_rentals"`
}

// RentalTrend 租赁趋势
type RentalTrend struct {
	Make      string `gorm:"column:make" json:"make"`
	Model     string `gorm:"column:model" json:"model"`
	IsStudent int    `gorm:"column:is_student" json:"is_student"`
	Num       int    `gorm:"column:number_of_times_rented" json:"number_of_times_rented"`
}

// IncreasePriceParams 提高价格参数
type IncreasePriceParams struct {
	HourlyIncrease float32 `gorm:"column:hourly_increase" json:"hourly_increase" binding:"required"`
	DailyIncrease  float32 `gorm:"column:daily_increase" json:"daily_increase" binding:"required"`
}

// Customers 表
type Customers struct {
	// old key need to define as pointer type so that we can know if is set by nil.
	OldKeyValue    *string   `gorm:"-" json:"old_key_value,omitempty"`
	CusID          int       `gorm:"column:cus_id,autoIncrement;" json:"cus_id"`
	LastName       string    `gorm:"column:last_name" json:"last_name" binding:"required"`
	FirstName      string    `gorm:"column:first_name" json:"first_name" binding:"required"`
	HomeTown       string    `gorm:"column:home_town" json:"home_town" binding:"required"`
	CellPhone      string    `gorm:"column:cell_phone" json:"cell_phone" binding:"required"`
	Email          string    `gorm:"column:email" json:"email" binding:"required"`
	CreditCard     string    `gorm:"column:cell_phone" json:"credit_card" binding:"required"`
	IsStudent      int       `gorm:"column:is_student" json:"is_student" binding:"required"`
	LicenseNumber  string    `gorm:"column:license_number" json:"license_number"`
	LicenseState   string    `gorm:"column:license_state" json:"license_state"`
	ExpirationDate LocalTime `gorm:"column:expiration_date" json:"expiration_date"`
}
