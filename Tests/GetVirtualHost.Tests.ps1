﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\TestSetup.ps1"
. "$here\..\Get-RabbitMQVirtualHost.ps1"

Describe -Tags "Example" "Get-RabbitMQVirtualHost" {

    It "should get Virtual Hosts registered with the server" {

        $actual = Get-RabbitMQVirtualHost -BaseUri $server | select -ExpandProperty name 

        $expected = $("/", "vh1", "vh2")

        AssertAreEqual $actual $expected
    }

    It "should get Virtual Hosts filtered by name" {

        $actual = Get-RabbitMQVirtualHost -BaseUri $server vh* | select -ExpandProperty name 

        $expected = $("vh1", "vh2")

        AssertAreEqual $actual $expected
    }

    It "should get VirtualHost names to filter by from the pipe" {

        $actual = $('vh1', 'vh2') | Get-RabbitMQVirtualHost -BaseUri $server | select -ExpandProperty name 

        $expected = $("vh1", "vh2")

        AssertAreEqual $actual $expected
    }

    It "should get VirtualHost and BaseUri from the pipe" {

        $pipe = $(
            New-Object -TypeName psobject -Prop @{"BaseUri" = $server; "Name" = "vh1" }
            New-Object -TypeName psobject -Prop @{"BaseUri" = $server; "Name" = "vh2" }
        )

        $actual = $pipe | Get-RabbitMQVirtualHost | select -ExpandProperty name 

        $expected = $("vh1", "vh2")

        AssertAreEqual $actual $expected
    }

    It "should pipe result from itself" {

        $actual = Get-RabbitMQVirtualHost -BaseUri $server | Get-RabbitMQVirtualHost | select -ExpandProperty name 

        $expected = Get-RabbitMQVirtualHost -BaseUri $server | select -ExpandProperty name 

        AssertAreEqual $actual $expected
    }
}

