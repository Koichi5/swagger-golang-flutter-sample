package services

import (
	"fmt"

	"github.com/Koichi5/swagger_golang_flutter_sample/models"
	"github.com/Koichi5/swagger_golang_flutter_sample/repositories"
)

type MemoService struct {
    repo *repositories.MemoRepository
}

func NewMemoService(repo *repositories.MemoRepository) *MemoService {
    return &MemoService{repo: repo}
}

func (s *MemoService) CreateMemo(memo *models.Memo) error {
    return s.repo.Create(memo)
}

func (s *MemoService) GetAllMemos() ([]models.Memo, error) {
    memos, err := s.repo.GetAll()
    // デバッグ出力を追加
    for _, memo := range memos {
        fmt.Printf("Service: Memo ID=%v, Title=%s\n", memo.ID, memo.Title)
    }
    return memos, err}

func (s *MemoService) GetMemoByID(id uint) (*models.Memo, error) {
    return s.repo.GetByID(id)
}

func (s *MemoService) UpdateMemo(id uint, title, content string, tags []string) (*models.Memo, error) {
    memo, err := s.repo.GetByID(id)
    if err != nil {
        return nil, err
    }

    memo.Title = title
    memo.Content = content
    memo.Tags = tags

    err = s.repo.Update(memo)
    if err != nil {
        return nil, err
    }

    return memo, nil
}

func (s *MemoService) DeleteMemo(id uint) error {
    return s.repo.Delete(id)
}

func (s *MemoService) SearchMemos(keyword string) ([]models.Memo, error) {
	return s.repo.SearchMemos(keyword)
}

func (s *MemoService) GetMemosByTag(tag string) ([]models.Memo, error) {
    return s.repo.GetByTag(tag)
}
