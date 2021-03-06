﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\TestSetup.ps1"
. "$here\..\Get-RabbitMQOverview.ps1"

Describe -Tags "Example" "Get-RabbitMQOverview" {

    It "should get server overview" {

        $actual = Get-RabbitMQOverview -BaseUri $server | select -ExpandProperty ComputerName

        $actual | Should Be $server
    }

    It "should get overview for several servers" {

        $actual = Get-RabbitMQOverview -BaseUri $server, $server | select -ExpandProperty ComputerName

        $actual | Should Be $server
    }

    It "should get server names from pipe" {

        $actual = $($($server) | Get-RabbitMQOverview) | select -ExpandProperty ComputerName

        $actual | Should Be $server
    }
}