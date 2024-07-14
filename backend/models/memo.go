package models

import (
	"database/sql/driver"
	"encoding/json"
	"gorm.io/gorm"
)

type Memo struct {
	gorm.Model
	Title   string `json:"title"`
	Content string `json:"content"`
	Tags    Tags   `json:"tags" gorm:"type:text"`
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