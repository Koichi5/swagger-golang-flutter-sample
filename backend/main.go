package main

import (
	"log"
	"github.com/Koichi5/swagger_golang_flutter_sample/database"
	"github.com/Koichi5/swagger_golang_flutter_sample/handlers"
	"github.com/Koichi5/swagger_golang_flutter_sample/repositories"
	"github.com/Koichi5/swagger_golang_flutter_sample/services"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func main() {
	database.ConnectDatabase()
	if err := database.MigrateDB(database.DB); err != nil {
		log.Fatalf("Failed to migrate database: %v", err)
	}

	r := setupRouter(database.DB)
	r.Run(":8080")
}

func setupRouter(db *gorm.DB) *gin.Engine {
    router := gin.Default()

    memoRepo := repositories.NewMemoRepository(db)
    memoService := services.NewMemoService(memoRepo)
    memoHandler := handlers.NewMemoHandler(memoService)

    router.POST("/memos", memoHandler.CreateMemo)
    router.GET("/memos", memoHandler.GetAllMemos)
    router.GET("/memos/:id", memoHandler.GetMemoByID)
    router.PUT("/memos/:id", memoHandler.UpdateMemo)
    router.DELETE("/memos/:id", memoHandler.DeleteMemo)
    router.GET("/memos/search", memoHandler.SearchMemos)

    return router
}