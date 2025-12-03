variable "cpu" {
  type        = string
  default     = "1"
  description = <<EOF
The number of CPU units to allocate to the container.
Can be specified in vCPUs (e.g., "1") or millivCPUs (e.g., "1000m").
Default is 1 vCPU.
EOF
}

variable "memory" {
  type        = string
  default     = "512Mi"
  description = <<EOF
The amount of memory to allocate to the container.
Can be specified in bytes (e.g., "536870912") or with a suffix (e.g., "512Mi", "2Gi").
Default is 512Mi.
EOF
}

variable "command" {
  type        = list(string)
  default     = []
  description = <<EOF
Entrypoint array (command to execute when the container starts).
If not specified, the container image's ENTRYPOINT is used.
Each token in the command is an item in the list.
For example, `echo "Hello World"` would be represented as ["echo", "Hello World"].
EOF
}

variable "timeout_seconds" {
  type        = number
  default     = 3600
  description = <<EOF
Maximum number of seconds the job is allowed to run before being terminated.
Must be between 0 and 86400 (24 hours).
Default is 3600 seconds (1 hour).
EOF
}

variable "parallelism" {
  type        = number
  default     = 0
  description = <<EOF
Maximum number of tasks that can run in parallel.
The default is 0 which disables limits on the number of parallel tasks.
EOF
}
