package models

import (
	"database/sql/driver"
	"encoding/json"
	"time"
	"gorm.io/gorm"
)

type Memo struct {
    ID        uint      `json:"id" gorm:"primarykey"`
    CreatedAt time.Time `json:"createdAt"`
    UpdatedAt time.Time `json:"updatedAt"`
    DeletedAt gorm.DeletedAt `json:"deletedAt,omitempty" gorm:"index"`
    Title     string    `json:"title"`
    Content   string    `json:"content"`
    Tags      Tags      `json:"tags" gorm:"type:text"`
}

type Tags []string

func (t Tags) Value() (driver.Value, error) {
	if len(t) == 0 {
		return nil, nil
	}
	return json.Marshal(t)
}

func (t *Tags) Scan(value interface{}) error {
	if value == nil {
		*t = nil
		return nil
	}
	return json.Unmarshal(value.([]byte), t)
}