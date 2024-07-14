package database

import (
	"github.com/Koichi5/swagger_golang_flutter_sample/models"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	database, err := gorm.Open(sqlite.Open("memos.db"), &gorm.Config{})
	if err != nil {
		panic("Failed to connect to database!")
	}

	database.AutoMigrate(&models.Memo{})

	DB = database
}

func MigrateDB(db *gorm.DB) error {
    return db.AutoMigrate(&models.Memo{})
}