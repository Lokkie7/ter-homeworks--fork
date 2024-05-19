resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
  { 
    webservers = yandex_compute_instance.platform
    databases = yandex_compute_instance.platform2
    storage = yandex_compute_instance.platform3
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "random_password" "solo" {
  length = 17
#> type.random_password.solo  list(object)
}

resource "random_password" "count" {
  count    = length([ for i in yandex_compute_instance.platform: i])
  length = 17
#> type(random_password.count)  list(object)
}

resource "random_password" "each" {
  for_each    = toset([for k, v in yandex_compute_instance.platform2 : v.name ])
  length = 17
#> type(random_password.each) object(object)
}

variable "web_provision" {
  type    = bool
  default = true
  description="ansible provision switch variable"
}

resource "null_resource" "web_hosts_provision" {
  count = var.web_provision == true ? 1 : 0 #var.web_provision ? 1 : 0
  depends_on = [yandex_compute_instance.platform, yandex_compute_instance.platform2, yandex_compute_instance.platform3]
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }
  provisioner "local-exec" {
    # without secrets
    # command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"

    #secrets pass
    #> nonsensitive(jsonencode( {for k,v in random_password.each: k=>v.result}))
    /*
      "{\"netology-develop-platform-web-0\":\"u(qzeC#nKjp*wTOY\",\"netology-develop-platform-web-1\":\"=pA12\\u0026C2eCl[Oe$9\"}"
    */
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml --extra-vars '{\"secrets\": ${jsonencode( {for k,v in random_password.each: k=>v.result})} }'"

    # for complex cases instead  --extra-vars "key=value", use --extra-vars "@some_file.json"

    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    # always_run        = "${timestamp()}"                         #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    ssh_public_key    = var.vms_ssh_root_key                           # при изменении переменной with ssh
    template_rendered = "${local_file.hosts_templatefile.content}" #при изменении inventory-template
    password_change = jsonencode( {for k,v in random_password.each: k=>v.result})

  }
}

