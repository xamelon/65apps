# Объясните почему блок "Work 2" не выполняется?

```
	let serialQueue = DispatchQueue(label: "com.foo.bar") 
	serialQueue.async { print("Work 1") 
		serialQueue.sync { print("Work 2") 
		} 
	}
```

Нельзя вызывать dispatch_sync в той же queue, из которой ее вызвали - происходит deadlock

