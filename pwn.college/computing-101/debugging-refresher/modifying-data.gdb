start
break *main+620
commands
	set {int}($rbp-0x10) = 0
	set $rdi = $rbp-0x10
	continue
end
break *main+682
commands
	set $rdx = *(uint64_t *)($rbp-0x18)
	continue
end
continue
continue
