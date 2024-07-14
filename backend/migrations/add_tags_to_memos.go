package migrations

import "gorm.io/gorm"

func AddTagsToMemos(db *gorm.DB) error {
	return db.Exec("ALTER TABLE memos ADD COLUMN tags TEXT").Error
}