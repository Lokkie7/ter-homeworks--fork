## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13                                                                                                                     |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.develop](https://registry.terraform.io/providers/yandex-cloud/y                                                                                                                    andex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.develop](https://registry.terraform.io/providers/yandex-cloud/ya                                                                                                                    ndex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | n/a | `a                                                                                                                    ny` | n/a | yes |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | n/a | `a                                                                                                                    ny` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `any` | n/a |                                                                                                                     yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_yandex_vpc_network"></a> [yandex\_vpc\_network](#output\_yandex\_vp                                                                                                                    c\_network) | n/a |
| <a name="output_yandex_vpc_subnet"></a> [yandex\_vpc\_subnet](#output\_yandex\_vpc\                                                                                                                    _subnet) | n/a |
