# Домашнее задание к занятию "`Командная работа Terraform`" - `Татаринцев Алексей`


---

### Задание 1


1. `Для начала установлю инструменты tflint и checkov.`

```
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
и проверяем версию

alexey@dell:~$ tflint --version
TFLint version 0.58.0
+ ruleset.terraform (0.12.0-bundled)

```



2. `Также делаем для checkov`
```
sudo apt update
sudo apt install python3-pip -y
pip3 install checkov
и проверяем версию
checkov --version
```
3. `Захожу в папку ter-homeworks/04/src/ и проверяю tflint`

```
Вижу ошибки

alexey@dell:~/ter-homeworks/04/src$ tflint
4 issue(s) found:

Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] variable "vms_ssh_root_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 36:
  36: variable "vms_ssh_root_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_web_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 43:
  43: variable "vm_web_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_db_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 50:
  50: variable "vm_db_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_unused_declarations.md

alexey@dell:~/ter-homeworks/04/src$ 

  on variables.tf line 50:
  50: variable "vm_db_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_unused_declarations.md.0/docs/rules/terraform_unused_declarations.md

```
4. `Следом проверяю второй репозитори ter-homeworks/04/demonstration1/vms/`

```
alexey@dell:~$ cd ter-homeworks/04/demonstration1/vms/
alexey@dell:~/ter-homeworks/04/demonstration1/vms$ tflint
5 issue(s) found:

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 23:
  23:   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_module_pinned_source.md

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 46:
  46:   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_module_pinned_source.md

Warning: Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)

  on main.tf line 64:
  64: data "template_file" "cloudinit" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] variable "public_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 3:
   3: variable "public_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.12.0/docs/rules/terraform_unused_declarations.md

```

5. `И проверка Checkov`

![1](https://github.com/Foxbeerxxx/team_terraform/blob/main/img/img1.png)

```
alexey@dell:~/ter-homeworks/04/demonstration1/vms$ checkov -d .
2025-06-14 19:46:17,367 [MainThread  ] [WARNI]  Failed to download module git::https://github.com/udjin10/yandex_compute_instance.git?ref=main:None (for external modules, the --download-external-modules flag is required)
[ kubernetes framework ]: 100%|████████████████████|[1/1], Current File Scanned=cloud-init.yml
[ terraform framework ]: 100%|████████████████████|[4/4], Current File Scanned=variables.tf           
[ ansible framework ]: 100%|████████████████████|[1/1], Current File Scanned=cloud-init.yml
[ secrets framework ]: 100%|████████████████████|[5/5], Current File Scanned=./variables.tf           

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.2.441 

terraform scan results:

Passed checks: 0, Failed checks: 4, Skipped checks: 0

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /main.tf:22-43
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: test-vm
        File: /main.tf:22-43
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-tag

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: example-vm
        File: /main.tf:45-61
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

                45 | module "example-vm" {
                46 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                47 |   env_name       = "stage"
                48 |   network_id     = yandex_vpc_network.develop.id
                49 |   subnet_zones   = ["ru-central1-a"]
                50 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id]
                51 |   instance_name  = "web-stage"
                52 |   instance_count = 1
                53 |   image_family   = "ubuntu-2004-lts"
                54 |   public_ip      = true
                55 | 
                56 |   metadata = {
                57 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                58 |     serial-port-enable = 1
                59 |   }
                60 | 
                61 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: example-vm
        File: /main.tf:45-61
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-tag

                45 | module "example-vm" {
                46 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                47 |   env_name       = "stage"
                48 |   network_id     = yandex_vpc_network.develop.id
                49 |   subnet_zones   = ["ru-central1-a"]
                50 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id]
                51 |   instance_name  = "web-stage"
                52 |   instance_count = 1
                53 |   image_family   = "ubuntu-2004-lts"
                54 |   public_ip      = true
                55 | 
                56 |   metadata = {
                57 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                58 |     serial-port-enable = 1
                59 |   }
                60 | 
                61 | }

```

---



### Задание 2



1. `В YC создал Object Storage,он у меня называется fbr`
2. `Создал серввисный аккаунт baket`

![3](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img3.png)

3. `Положил все секреты в ~/.aws/credentials, папку и файл создал сам`
4. `Запустил тест на demo для  провеки , какие ошибки будут и посмотреть как это работает`

![2](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img2.png)

5. `Demo с лекции отработало , пробую загрузить свой стейт с ДЗ 4`
6. `Добавил изменения в провайдерс папку под стейт файл назвал Terraform 05 `

![4](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img4.png)

7. `Файл загружен `
8. `Настраиваем блокировку, добавляем DB в YC`

![5](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img5.png)

9. `После внесения изменений, запускаю terragorm applly держу стайт файл`
![6](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img6.png)

10. `И проверяю в YC`
![7](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img7.png)

11. `Разблокирую по id`
![8](https://github.com/Foxbeerxxx/team_terraform/blob/terraform-05/img/img8.png)

12. `Блокировка снята`



---

### Задание 3

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`

### Задание 4

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`
