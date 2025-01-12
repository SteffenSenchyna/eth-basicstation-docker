curl --location --globoff --request PUT 'https://{{host}}/services/configuration/v2/configurableComponents/configurations/_update' \
--header 'X-XSRF-Token: {{xsrf_token}}' \
--data '{
    "configs": [
        {
            "pid": "basicstation",
            "properties": {
                "container.loggingType": {
                    "value": "DEFAULT",
                    "type": "STRING"
                },
                "container.image.tag": {
                    "value": "aarch64-latest",
                    "type": "STRING"
                },
                "registry.hostname": {
                    "value": "",
                    "type": "STRING"
                },
                "container.memory": {
                    "value": "",
                    "type": "STRING"
                },
                "container.image.download.timeout": {
                    "value": 500,
                    "type": "INTEGER"
                },
                "service.factoryPid": {
                    "value": "org.eclipse.kura.container.provider.ContainerInstance",
                    "type": "STRING"
                },
                "container.device": {
                    "value": "",
                    "type": "STRING"
                },
                "container.volume": {
                    "value": "",
                    "type": "STRING"
                },
                "container.signature.trust.anchor": {
                    "value": "",
                    "type": "STRING"
                },
                "container.privileged": {
                    "value": true,
                    "type": "BOOLEAN"
                },
                "container.signature.enforcement.digest": {
                    "value": "",
                    "type": "STRING"
                },
                "container.gpus": {
                    "value": "",
                    "type": "STRING"
                },
                "container.enabled": {
                    "value": true,
                    "type": "BOOLEAN"
                },
                "container.image.download.retries": {
                    "value": 5,
                    "type": "INTEGER"
                },
                "container.loggerParameters": {
                    "value": "max-size=10m",
                    "type": "STRING"
                },
                "container.restart.onfailure": {
                    "value": true,
                    "type": "BOOLEAN"
                },
                "registry.username": {
                    "value": "",
                    "type": "STRING"
                },
                "container.env": {
                    "value": "MODEL=SX1301,USE_CUPS=0,TC_URI=$TC_URI,API_URI=$API_URI,GW_POWER_EN_GPIO=GPIO119,GW_RESET_GPIO=GPIO122,GW_POWER_EN_LOGIC=0,CS_KEY=$CS_KEY",
                    "type": "STRING"
                },
                "container.signature.verify.transparency.log": {
                    "value": true,
                    "type": "BOOLEAN"
                },
                "container.ports.internal": {
                    "value": "",
                    "type": "STRING"
                },
                "kura.service.pid": {
                    "value": "basicstation",
                    "type": "STRING"
                },
                "service.pid": {
                    "value": "org.eclipse.kura.container.provider.ContainerInstance-1736457372108-22",
                    "type": "STRING"
                },
                "container.image.download.interval": {
                    "value": 30000,
                    "type": "INTEGER"
                },
                "container.runtime": {
                    "value": "",
                    "type": "STRING"
                },
                "container.networkMode": {
                    "value": "host",
                    "type": "STRING"
                },
                "container.ports.external": {
                    "value": "",
                    "type": "STRING"
                },
                "container.entrypoint": {
                    "value": "",
                    "type": "STRING"
                },
                "container.image": {
                    "value": "registry.gitlab.com/steffen.senchyna/eth-basicstation",
                    "type": "STRING"
                }
            }
        }
    ]
}'