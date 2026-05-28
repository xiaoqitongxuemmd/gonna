package logic

import (
	"context"

	"gonna/services/system-rpc/internal/svc"
	"gonna/services/system-rpc/system"

	"github.com/zeromicro/go-zero/core/logx"
)

type PingLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewPingLogic(ctx context.Context, svcCtx *svc.ServiceContext) *PingLogic {
	return &PingLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *PingLogic) Ping(in *system.PingRequest) (*system.PingResponse, error) {
	if in.Message == "" {
		return &system.PingResponse{Message: "pong"}, nil
	}

	return &system.PingResponse{Message: in.Message}, nil
}
