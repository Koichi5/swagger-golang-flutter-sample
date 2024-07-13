package main

import (
	"github.com/gin-gonic/gin"
	"github.com/Koichi5/swagger_golang_flutter_sample/database"
	"github.com/Koichi5/swagger_golang_flutter_sample/handlers"
)

func main() {
	r := gin.Default()

	database.ConnectDatabase()

	r.GET("/memos", handlers.GetMemos)
	r.POST("/memos", handlers.CreateMemo)
	r.GET("/memos/:id", handlers.GetMemo)
	r.PUT("/memos/:id", handlers.UpdateMemo)
	r.DELETE("/memos/:id", handlers.DeleteMemo)

	r.Run(":8080")
}