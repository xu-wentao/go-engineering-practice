# Exercise 01 - Concurrent HTTP Health Checker

实现一个命令行工具，从文件中读取 URL，并发检查目标服务的 HTTP 状态。

## 使用示例

```bash
go run ./cmd/checker \
  -file ./testdata/urls.txt \
  -concurrency 5 \
  -timeout 3s \
  -retries 2 \
  -output text
```

## 功能要求

- [ ] 使用 `-file` 指定 URL 文件
- [ ] 使用 `-concurrency` 限制最大并发数
- [ ] 使用 `-timeout` 设置单次请求超时
- [ ] 使用 `-retries` 设置失败重试次数
- [ ] 支持 `text` 和 `json` 两种输出格式
- [ ] 输出 URL、HTTP 状态码、耗时和错误信息
- [ ] 收到 `SIGINT` 或 `SIGTERM` 后停止创建新任务
- [ ] 等待已经开始的任务结束，或在总 Context 取消后退出
- [ ] 不产生 goroutine 泄漏

## 建议数据结构

```go
type CheckResult struct {
    URL        string        `json:"url"`
    StatusCode int           `json:"status_code"`
    Duration   time.Duration `json:"duration"`
    Attempts   int           `json:"attempts"`
    Error      string        `json:"error,omitempty"`
}

type Checker interface {
    Check(ctx context.Context, target string) CheckResult
}
```

接口只是建议，可以在 Pull Request 中说明采用其他设计的理由。

## 行为约定

### 输入文件

- 每行一个 URL
- 忽略空行
- 忽略以 `#` 开头的注释
- URL 不合法时生成失败结果，不应导致整个程序退出

### 重试

- 网络错误可以重试
- 请求超时可以重试
- HTTP `5xx` 可以重试
- HTTP `4xx` 默认不重试
- Context 被取消后立即停止重试

### 退出码

- 所有检查成功：`0`
- 至少一个检查失败：`1`
- 参数或输入文件错误：`2`

## 测试要求

使用 `httptest.Server`，至少覆盖：

- [ ] 正常返回 `200`
- [ ] 返回 `500` 后重试并成功
- [ ] 请求超时
- [ ] 非法 URL
- [ ] 实际并发数不超过配置值
- [ ] Context 取消会停止等待和重试
- [ ] JSON 输出可以被正常解析

## 工程要求

```bash
gofmt -w .
go vet ./...
go test -race -cover ./...
```

禁止：

- 为每个 URL 无限制创建 goroutine
- 使用全局可变状态保存结果
- 使用 `time.Sleep` 实现不可取消的重试等待
- 在业务代码中直接调用 `os.Exit`

## 加分项

- 指数退避和随机抖动
- 保持输出顺序与输入顺序一致
- 支持从标准输入读取 URL
- 输出成功率和延迟统计
- Benchmark 或 goroutine 泄漏测试

## 完成后的复盘

在本文件末尾补充：

- 最终并发模型
- Context 的传递方式
- 遇到的竞态或泄漏问题
- 测试中最难覆盖的场景
- 下一次会如何改进设计
