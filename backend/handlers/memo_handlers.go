package handlers

import (
	"net/http"
	"github.com/gin-gonic/gin"
	"github.com/Koichi5/swagger_golang_flutter_sample/database"
	"github.com/Koichi5/swagger_golang_flutter_sample/models"
)

func GetMemos(c *gin.Context) {
	var memos []models.Memo
	database.DB.Find(&memos)
	c.JSON(http.StatusOK, memos)
}

func CreateMemo(c *gin.Context) {
	var memo models.Memo
	if err := c.ShouldBindJSON(&memo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	database.DB.Create(&memo)
	c.JSON(http.StatusCreated, memo)
}

func GetMemo(c *gin.Context) {
	var memo models.Memo
	id := c.Param("id")

	if err := database.DB.First(&memo, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Memo not found"})
		return
	}

	c.JSON(http.StatusOK, memo)
}

func UpdateMemo(c *gin.Context) {
	var memo models.Memo
	id := c.Param("id")

	if err := database.DB.First(&memo, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Memo not found"})
		return
	}

	var updatedMemo models.Memo
	if err := c.ShouldBindJSON(&updatedMemo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	memo.Title = updatedMemo.Title
	memo.Content = updatedMemo.Content

	database.DB.Save(&memo)
	c.JSON(http.StatusOK, memo)
}

func DeleteMemo(c *gin.Context) {
	var memo models.Memo
	id := c.Param("id")

	if err := database.DB.First(&memo, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Memo not found"})
		return
	}

	database.DB.Delete(&memo)
	c.JSON(http.StatusNoContent, nil)
}