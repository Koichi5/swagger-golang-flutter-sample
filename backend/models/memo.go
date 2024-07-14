package models

import (
	"gorm.io/gorm"
)

type Memo struct {
	gorm.Model
	Title   string `json:"title"`
	Content string `json:"content"`
}