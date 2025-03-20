# **Commoin 3rd Party Libraries in Go**

## Sources:
- awesome-go: (https://github.com/avelino/awesome-go)
- go.dev/pkg: (https://pkg.go.dev/std)

## **Summary of Essential Libraries**

| **Category**      | **Library**              | **Description** |
|------------------|------------------------|---------------|
| **Config**      | `viper`                 | Reads config from files, env variables |
| **Logging**     | `zap`                    | High-performance structured logging |
| **Routing**     | `chi`                    | Lightweight HTTP router |
| **Database**    | `gorm`                   | ORM for SQL databases |
| **Concurrency** | `workerpool`             | Efficient worker pools |
| **JSON**        | `easyjson`               | Fast JSON handling |
| **Environment** | `godotenv`               | Load `.env` files |
| **Testing**     | `testify`                | Assertions & mocking |

---

## **1️⃣ Configuration Management: Viper**
**Library:** [`github.com/spf13/viper`](https://github.com/spf13/viper)

**Why?** Reads configuration from YAML, JSON, ENV variables, etc.

### **Example: Loading a Config File**
```go
viper.SetConfigName("config")  // config.yaml
viper.SetConfigType("yaml")    // YAML format
viper.AddConfigPath(".")       // Current directory

if err := viper.ReadInConfig(); err != nil {
    log.Fatalf("Error reading config file: %v", err)
}
```

✅ **Features:**
- Supports YAML, JSON, TOML, and ENV files
- Automatic reloading
- Merges multiple config sources

---

## **2️⃣ Logging: Zap**
**Library:** [`go.uber.org/zap`](https://github.com/uber-go/zap)

**Why?** High-performance, structured logging.

### **Example: Using Zap for Logging**
```go
logger, _ := zap.NewProduction()
defer logger.Sync()

logger.Info("Application started",
    zap.String("version", "1.0.0"),
    zap.Int("port", 8080),
)
```

✅ **Features:**
- Fast & efficient (zero-allocation logging)
- Structured logs (JSON-based logging)
- Logging levels: Debug, Info, Warn, Error, Fatal

---

## **3️⃣ HTTP Router: Chi**
**Library:** [`github.com/go-chi/chi`](https://github.com/go-chi/chi)

**Why?** Lightweight, fast, and easy-to-use router.

### **Example: Creating an API**
```go
r := chi.NewRouter()
r.Get("/hello", func(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Hello, World!"))
})

http.ListenAndServe(":8080", r)
```

✅ **Features:**
- Lightweight (low memory footprint)
- Middleware support
- Nested routes

---

## **4️⃣ Database Access: GORM**
**Library:** [`gorm.io/gorm`](https://github.com/go-gorm/gorm)

**Why?** ORM for Go with support for MySQL, PostgreSQL, SQLite.

### **Example: Using GORM**
```go
db, err := gorm.Open(sqlite.Open("test.db"), &gorm.Config{})
if err != nil {
    panic("Failed to connect to database")
}

db.AutoMigrate(&User{}) // Create table
db.Create(&User{Name: "Alice", Age: 25})
```

✅ **Features:**
- Easy-to-use ORM
- Auto-migration for DB schema
- Supports SQL databases (PostgreSQL, MySQL, SQLite, etc.)

---

## **5️⃣ Concurrent Task Processing: Workerpool**
**Library:** [`github.com/gammazero/workerpool`](https://github.com/gammazero/workerpool)

**Why?** Efficient worker pool for concurrent tasks.

### **Example: Running a Worker Pool**
```go
wp := workerpool.New(3) // Limit to 3 concurrent workers
for i := 1; i <= 5; i++ {
    n := i
    wp.Submit(func() {
        fmt.Println("Processing job", n)
    })
}
wp.StopWait()
```

✅ **Features:**
- Efficient concurrency handling
- Prevents goroutine explosion

---

## **6️⃣ JSON Handling: Easyjson**
**Library:** [`github.com/mailru/easyjson`](https://github.com/mailru/easyjson)

**Why?** Faster JSON serialization than `encoding/json`.

### **Example: Fast JSON Serialization**
```go
//go:generate easyjson -all mystruct.go
package main

type User struct {
    Name  string `json:"name"`
    Email string `json:"email"`
}
```

✅ **Features:**
- Generates optimized JSON parsers
- Much faster than Go's built-in `encoding/json`

---

## **7️⃣ Environment Variables: Godotenv**
**Library:** [`github.com/joho/godotenv`](https://github.com/joho/godotenv)

**Why?** Loads `.env` files for config.

### **Example: Reading an `.env` File**
```go
err := godotenv.Load()
if err != nil {
    log.Fatal("Error loading .env file")
}
fmt.Println("API Key:", os.Getenv("API_KEY"))
```

✅ **Features:**
- Loads env variables from `.env` files
- Useful for local development

---

## **8️⃣ Testing & Mocks: Testify**
**Library:** [`github.com/stretchr/testify`](https://github.com/stretchr/testify)

**Why?** Makes writing tests easier.

### **Example: Writing Tests with Testify**
```go
package main

testing.T

github.com/stretchr/testify/assert

func TestAdd(t *testing.T) {
    result := Add(2, 3)
    assert.Equal(t, 5, result, "they should be equal")
}
```

✅ **Features:**
- Assertions for testing
- Mocking support
