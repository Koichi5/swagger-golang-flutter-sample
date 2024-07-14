package handlers

import (
	"net/http"
	"strconv"
	"github.com/Koichi5/swagger_golang_flutter_sample/models"
	"github.com/Koichi5/swagger_golang_flutter_sample/services"
	"github.com/gin-gonic/gin"
)

type MemoHandler struct {
    service *services.MemoService
}

func NewMemoHandler(service *services.MemoService) *MemoHandler {
    return &MemoHandler{service: service}
}

func (h *MemoHandler) CreateMemo(c *gin.Context) {
    var input struct {
        Title   string   `json:"title" binding:"required"`
        Content string   `json:"content" binding:"required"`
        Tags    []string `json:"tags"`
    }
    if err := c.ShouldBindJSON(&input); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    memo := &models.Memo{
        Title:   input.Title,
        Content: input.Content,
        Tags:    input.Tags,
    }

    if err := h.service.CreateMemo(memo); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusCreated, memo)
}

func (h *MemoHandler) GetAllMemos(c *gin.Context) {
    memos, err := h.service.GetAllMemos()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, memos)
}

func (h *MemoHandler) GetMemoByID(c *gin.Context) {
    id, _ := strconv.ParseUint(c.Param("id"), 10, 32)
    memo, err := h.service.GetMemoByID(uint(id))
    if err != nil {
        c.JSON(http.StatusNotFound, gin.H{"error": "Memo not found"})
        return
    }

    c.JSON(http.StatusOK, memo)
}

func (h *MemoHandler) UpdateMemo(c *gin.Context) {
    id, err := strconv.ParseUint(c.Param("id"), 10, 32)
    if err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
        return
    }

    var input struct {
        Title   string `json:"title"`
        Content string `json:"content"`
        Tags []string `json:"tags"`
    }
    if err := c.ShouldBindJSON(&input); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    updatedMemo, err := h.service.UpdateMemo(uint(id), input.Title, input.Content, input.Tags)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, updatedMemo)
}

func (h *MemoHandler) DeleteMemo(c *gin.Context) {
    id, _ := strconv.ParseUint(c.Param("id"), 10, 32)
    if err := h.service.DeleteMemo(uint(id)); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, gin.H{"message": "Memo deleted successfully"})
}

func (h *MemoHandler) SearchMemos(c *gin.Context) {
	keyword := c.Query("keyword")
	if keyword == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Keyword is required"})
		return
	}

	memos, err := h.service.SearchMemos(keyword)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, memos)
}

func (h *MemoHandler) GetMemosByTag(c *gin.Context) {
    tag := c.Query("tag")
    if tag == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Tag is required"})
        return
    }

    memos, err := h.service.GetMemosByTag(tag)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, memos)
}
