﻿$BaseUriCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $global:RabbitMQServers
}

$virtualHostCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQVirtualHost @parms | where name -like "$wordToComplete*" | select name | ForEach-Object { 
        $vhname = @{$true="Default"; $false= $_.name}[$_.name -eq "/"]
        $cname = @{$true="localhost"; $false = $fakeBoundParameter.BaseUri}[$fakeBoundParameter.BaseUri -eq $null]
        $tooltip = "$vhname on $cname."
        
        createCompletionResult $_.name $_.name $tooltip
    }
}

$exchangeCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.VirtualHost) { $parms.Add("VirtualHost", $fakeBoundParameter.VirtualHost) }
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQExchange @parms | where name -like "$wordToComplete*" | select name | ForEach-Object { 
        $ename = @{$true="(AMQP default)"; $false=$_.name}[$_.name -eq ""]
        $vhname = @{$true="[default]"; $false= $fakeBoundParameter.VirtualHost}[$fakeBoundParameter.VirtualHost -eq "/"]
        $cname = @{$true="localhost"; $false = $fakeBoundParameter.BaseUri}[$fakeBoundParameter.BaseUri -eq $null]
        $tooltip = "$ename on $cname/$vhname."
        
        createCompletionResult $ename $ename $tooltip
    }
}

$connectionCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQConnection @parms | where name -like "$wordToComplete*" | select name | ForEach-Object { 
        $cname = @{$true="localhost"; $false = $fakeBoundParameter.BaseUri}[$fakeBoundParameter.BaseUri -eq $null]
        $tooltip = "$_.name on $cname."
        
        createCompletionResult $_.name $_.name $tooltip
    }
}

$nodeCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQNode @parms | where name -like "$wordToComplete*" | select name | ForEach-Object { 
        $cname = @{$true="localhost"; $false = $fakeBoundParameter.BaseUri}[$fakeBoundParameter.BaseUri -eq $null]
        $tooltip = $_.name + " on " + $cname + "."
        
        createCompletionResult $_.name $_.name $tooltip
    }
}

$channelCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.VirtualHost) { $parms.Add("VirtualHost", $fakeBoundParameter.VirtualHost) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQChannel @parms | where name -like "$wordToComplete*" | select name | ForEach-Object { 
        $cname = @{$true="localhost"; $false = $fakeBoundParameter.BaseUri}[$fakeBoundParameter.BaseUri -eq $null]
        $tooltip = $_.name + " on " + $cname + "."
        
        createCompletionResult $_.name $_.name $tooltip
    }
}

$queueCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.VirtualHost) { $parms.Add("VirtualHost", $fakeBoundParameter.VirtualHost) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQQueue @parms | where name -like "$wordToComplete*" | ForEach-Object { 
        $cname = @{$true="localhost"; $false = $fakeBoundParameter.BaseUri}[$fakeBoundParameter.BaseUri -eq $null]
        $n = "$($_.name) ($($_.messages))"
        $tooltip = "$($_.name) on $cname/$($_.vhost) ($($_.messages) messages)."

        createCompletionResult $n $_.name $tooltip
    }
}

$routingKeyGeneration_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.VirtualHost) { $parms.Add("VirtualHost", $fakeBoundParameter.VirtualHost) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    $tooltip = "Bind exchange " + $fakeBoundParameter.ExchangeName + " to queue " + $fakeBoundParameter.Name + "."
        
    createCompletionResult $fakeBoundParameter.Name $tooltip
    createCompletionResult $($fakeBoundParameter.ExchangeName + "-" + $fakeBoundParameter.Name) $tooltip
    createCompletionResult $($fakeBoundParameter.ExchangeName + "->" + $fakeBoundParameter.Name) $tooltip
    createCompletionResult $($fakeBoundParameter.ExchangeName + ".." + $fakeBoundParameter.Name) $tooltip
}

$routingKeyCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }
    if ($fakeBoundParameter.VirtualHost) { $parms.Add("VirtualHost", $fakeBoundParameter.VirtualHost) }
    #if ($fakeBoundParameter.ExchangeName) { $parms.Add("ExchangeName", $fakeBoundParameter.ExchangeName) }
    if ($fakeBoundParameter.Name) { $parms.Add("Name", $fakeBoundParameter.Name) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    #Get-RabbitMQQueueBinding @parms | where name -like "$wordToComplete*" | select routing_key | ForEach-Object { 
    $a = Get-RabbitMQQueueBinding @parms 
    $b = $a | where source -eq $fakeBoundParameter.ExchangeName | select routing_key 

    $b | ForEach-Object { 
        createCompletionResult $_.routing_key $_.routing_key $_.routing_key 
    }
}

$userCompletion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    $parms = @{}
    if ($fakeBoundParameter.BaseUri) { $parms.Add("BaseUri", $fakeBoundParameter.BaseUri) }

    if ($fakeBoundParameter.Credentials) { $parms.Add("Credentials", $fakeBoundParameter.Credentials) }
    if ($fakeBoundParameter.UserName) { $parms.Add("UserName", $fakeBoundParameter.UserName) }
    if ($fakeBoundParameter.Password) { $parms.Add("Password", $fakeBoundParameter.Password) }

    Get-RabbitMQUser @parms | where name -like "$wordToComplete*" | ForEach-Object { 
        $tooltip = "$($_.name) [$($_.tags)]"

        createCompletionResult $_.name $_.name $tooltip
    }
}

function createCompletionResult([string]$text, [string]$value, [string]$tooltip) {

    if ([string]::IsNullOrEmpty($value)) { return }
    if ([string]::IsNullOrEmpty($text)) { $text = $value }
    if ([string]::IsNullOrEmpty($tooltip)) { $tooltip = $value }
    
    $completionText = @{$true="'$value'"; $false=$value  }[$value -match "\W"]
    $completionText = $completionText -replace '\[', '``[' -replace '\]', '``]'
    
    return New-Object System.Management.Automation.CompletionResult $completionText, $text, 'ParameterValue', $tooltip 
}

if (-not $global:options) { $global:options = @{CustomArgumentCompleters = @{};NativeArgumentCompleters = @{}}}

$global:options['CustomArgumentCompleters']['Test1:Name'] = $testCompletion_Process 


$global:options['CustomArgumentCompleters']['Get-RabbitMQOverview:Name'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQVirtualHost:Name'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQVirtualHost:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQVirtualHost:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQVirtualHost:Name'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQVirtualHost:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQExchange:Name'] = $exchangeCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQExchange:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQExchange:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQExchange:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQExchange:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQExchange:Name'] = $exchangeCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQExchange:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQExchange:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQConnection:Name'] = $connectionCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQConnection:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQConnection:Name'] = $connectionCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQConnection:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQNode:Name'] = $nodeCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQNode:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQChannel:Name'] = $channelCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQChannel:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQChannel:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQQueue:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQQueue:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQQueue:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueue:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueue:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueue:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueue:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueue:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQQueueBinding:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQQueueBinding:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQQueueBinding:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueueBinding:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueueBinding:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueueBinding:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueueBinding:ExchangeName'] = $exchangeCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQQueueBinding:RoutingKey'] = $routingKeyGeneration_Process
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueueBinding:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueueBinding:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueueBinding:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueueBinding:ExchangeName'] = $exchangeCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQQueueBinding:RoutingKey'] = $routingKeyCompletion_Process

$global:options['CustomArgumentCompleters']['Get-RabbitMQMessage:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQMessage:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQMessage:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Clear-RabbitMQQueue:Name'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Clear-RabbitMQQueue:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Clear-RabbitMQQueue:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Copy-RabbitMQMessage:SourceQueueName'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Copy-RabbitMQMessage:DestinationQueueName'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Copy-RabbitMQMessage:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Copy-RabbitMQMessage:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Move-RabbitMQMessage:SourceQueueName'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Move-RabbitMQMessage:DestinationQueueName'] = $queueCompletion_Process 
$global:options['CustomArgumentCompleters']['Move-RabbitMQMessage:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Move-RabbitMQMessage:BaseUri'] = $BaseUriCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQUser:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQUser:Name'] = $userCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQUser:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQUser:Name'] = $userCompletion_Process 
$global:options['CustomArgumentCompleters']['Set-RabbitMQUser:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Set-RabbitMQUser:Name'] = $userCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQUser:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQUser:Name'] = $userCompletion_Process 

$global:options['CustomArgumentCompleters']['Get-RabbitMQPermission:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQPermission:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Get-RabbitMQPermission:User'] = $userCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQPermission:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQPermission:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Add-RabbitMQPermission:User'] = $userCompletion_Process 
$global:options['CustomArgumentCompleters']['Set-RabbitMQPermission:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Set-RabbitMQPermission:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Set-RabbitMQPermission:User'] = $userCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQPermission:BaseUri'] = $BaseUriCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQPermission:VirtualHost'] = $virtualHostCompletion_Process 
$global:options['CustomArgumentCompleters']['Remove-RabbitMQPermission:User'] = $userCompletion_Process 

$global:options['CustomArgumentCompleters']['Unregister-RabbitMQServer:BaseUri'] = $BaseUriCompletion_Process 

$function:tabexpansion2 = $function:tabexpansion2 -replace 'End\r\n{','End { if ($null -ne $options) { $options += $global:options} else {$options = $global:options}'
