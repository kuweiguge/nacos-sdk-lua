---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by huifer.
--- DateTime: 2020/12/10 13:00
---

local httpUtils = require("utils.HttpUtils")
local url = require("socket.url")

NacosConfigManager = {}
-- nacos open api
configUrl = "/nacos/v1/cs/configs"

-- 获取配置信息
function NacosConfigManager.getConfig(nacosDomain, tenant, dataId, group)
    if nacosDomain == nil then
        error("nacos domain is not null")
    end
    if dataId == nil then
        error("data id not null")
    end

    if group == nil or group == "" then
        group = "DEFAULT_GROUP"
    end

    if tenant == nil then
        tenant = ''
    end

    url = nacosDomain .. configUrl .. "?" .. "dataId=" .. dataId .. "&group=" .. group .. "&tenant=" .. tenant
    print("request url = " .. url)

    local body = httpUtils.wb_getUrl(url)
    if body ~= nil then
        return body
    end
end

-- 推送配置
function NacosConfigManager.pushConfig(nacosDomain, tenant, dataId, group, content, type)

    if nacosDomain == nil then
        error("nacos domain is not null")
    end
    if dataId == nil then
        error("data id not null")
    end

    if group == nil or group == "" then
        group = "DEFAULT_GROUP"
    end

    if tenant == nil then
        tenant = ''
    end

    if type == nil then
        type = ''
    end

    if content == nil then
        error("content is not null")
    end

    url = nacosDomain .. configUrl .. "?" .. "dataId=" .. dataId .. "&group=" .. group .. "&tenant="
            .. tenant .. "&content=" .. url.escape(content) .. "&type=" .. type

    print("request url = " .. url)

    local body = httpUtils.wb_postUrl(url)

    if body == 'true' then
        return true
    end

    return false


end

-- 删除配置
function NacosConfigManager.deleteConfig(nacosDomain, tenant, dataId, group)
    if nacosDomain == nil then
        error("nacos domain is not null")
    end

    if dataId == nil then
        error("data id not null")

    end

    if group == nil or group == "" then
        group = "DEFAULT_GROUP"
    end
    if tenant == nil then
        tenant = ''
    end

    --http://localhost:8848/nacos/v1/cs/configs?tenant&dataId=nacos.example&group=DEFAULT_GROUP


    url = nacosDomain .. configUrl .. "?" .. "dataId=" .. dataId .. "&group=" .. group .. "&tenant="
            .. tenant

    print("request url = " .. url)
    local var = httpUtils.wb_deleteUrl(url)
    if var == 'true' then
        return true
    end
    return false

end

return NacosConfigManager