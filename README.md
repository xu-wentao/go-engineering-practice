# Go Engineering Practice

面向真实工程场景的 Go 编程练习，重点训练并发控制、HTTP 服务、测试、可观测性、Kubernetes 和分布式系统能力，而不是算法刷题。

## 练习方式

每道题按照接近真实项目的流程完成：

1. 阅读题目和验收标准
2. 创建独立分支
3. 完成最小可用版本
4. 补充单元测试和异常场景
5. 创建 Pull Request
6. 根据 Code Review 修改
7. 合并后填写复盘记录

## 练习清单

| 编号 | 题目 | 核心知识点 | 状态 |
| --- | --- | --- | --- |
| 01 | Concurrent HTTP Health Checker | context、HTTP、worker pool、优雅退出 | Not Started |
| 02 | Configuration Loader | YAML、环境变量、校验、热加载 | Planned |
| 03 | TTL Cache | 泛型、锁、后台清理 | Planned |
| 04 | Generic Worker Pool | goroutine、channel、panic recovery | Planned |
| 05 | Task Management API | HTTP、分层设计、测试 | Planned |
| 06 | Retry and Circuit Breaker | 退避、抖动、状态机 | Planned |
| 07 | Rate Limiter | Token Bucket、HTTP middleware | Planned |
| 08 | Reverse Proxy | 负载均衡、健康检查 | Planned |
| 09 | Prometheus Exporter | 指标设计、后台采集 | Planned |
| 10 | Kubernetes Pod Observer | client-go、Informer、状态统计 | Planned |

详细进度见 [PROGRESS.md](./PROGRESS.md)。

## 质量要求

提交前至少执行：

```bash
make check
```

等价于：

```bash
gofmt -w .
go vet ./...
go test -race -cover ./...
```

## 分支和提交约定

分支示例：

```text
exercise/01-http-health-checker
```

提交示例：

```text
feat(checker): add concurrent URL checks

test(checker): cover timeout and retry behavior

refactor(checker): separate transport from orchestration
```

## 目录结构

```text
.
├── exercises/        # 每道独立练习
├── notes/            # 知识总结与错误复盘
├── .github/workflows # 持续集成
├── PROGRESS.md       # 总体进度
└── go.work           # 管理各练习模块
```
