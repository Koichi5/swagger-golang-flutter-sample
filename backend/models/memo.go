package models

import (
	"gorm.io/gorm"
)

type Memo struct {
	gorm.Model
	ID      string `json:"id"`
	Title   string `json:"title"`
	Content string `json:"content"`
}