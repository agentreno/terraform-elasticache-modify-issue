resource "aws_security_group" "group_one" {
    name = "group one"
    description = "Testing SG for terraform issue"

    ingress {
        from_port = 0
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "group_two" {
    name = "group two"
    description = "Testing SG for terraform issue"

    ingress {
        from_port = 0
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_elasticache_security_group" "test_cache" {
    name =  "test_cache"
    security_group_names = [
        "${aws_security_group.group_one.name}",
        # "${aws_security_group.group_two.name}"
    ]
}

resource "aws_elasticache_cluster" "test_cache" {
    cluster_id = "test-cache"
    engine = "redis"
    node_type = "cache.t1.micro"
    port = 6379
    num_cache_nodes = 1
    parameter_group_name = "default.redis3.2"
    security_group_names = ["${aws_elasticache_security_group.test_cache.name}"]
}
