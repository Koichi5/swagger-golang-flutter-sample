package repositories

import (
	"github.com/Koichi5/swagger_golang_flutter_sample/models"
	"gorm.io/gorm"
)

type MemoRepository struct {
    DB *gorm.DB
}

func NewMemoRepository(db *gorm.DB) *MemoRepository {
    return &MemoRepository{DB: db}
}

func (r *MemoRepository) Create(memo *models.Memo) error {
    return r.DB.Create(memo).Error
}

func (r *MemoRepository) GetAll() ([]models.Memo, error) {
    var memos []models.Memo
    err := r.DB.Find(&memos).Error
    return memos, err
}

func (r *MemoRepository) GetByID(id uint) (*models.Memo, error) {
    var memo models.Memo
    err := r.DB.First(&memo, id).Error
    if err != nil {
        return nil, err
    }
    return &memo, nil
}

func (r *MemoRepository) Update(memo *models.Memo) error {
    return r.DB.Model(memo).Updates(models.Memo{Title: memo.Title, Content: memo.Content}).Error
}

func (r *MemoRepository) Delete(id uint) error {
    return r.DB.Delete(&models.Memo{}, id).Error
}

func (r *MemoRepository) SearchMemos(keyword string) ([]models.Memo, error) {
	var memos []models.Memo
	result:= r.DB.Where("title LIKE ? OR description LIKE ?", "%"+keyword+"%", "%"+keyword+"%").Find(&memos)
	return memos, result.Error
}