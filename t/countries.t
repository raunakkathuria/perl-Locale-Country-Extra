#!/usr/bin/perl
use strict; use warnings;

use lib 'lib';
use Test::More (tests => 5);
use Test::NoWarnings;
use Locale::Country::Extra;

my $countries = Locale::Country::Extra->new();

subtest 'country_from_code' => sub {
    is $countries->country_from_code('au'), 'Australia',          'AU is Australia';
    is $countries->country_from_code('gb'), 'United Kingdom',     'GB is United Kingdom';
    is $countries->country_from_code('ru'), 'Russian Federation', 'RU is Russian Federation';
    is $countries->country_from_code('id'), 'Indonesia',          'ID is Indonesia';
    is $countries->country_from_code('AU'), 'Australia',          'AU is Australia';
    is $countries->country_from_code('GB'), 'United Kingdom',     'GB is United Kingdom';
    is $countries->country_from_code('RU'), 'Russian Federation', 'RU is Russian Federation';
    is $countries->country_from_code('ID'), 'Indonesia',          'ID is Indonesia';

    is $countries->country_from_code('uk'), 'United Kingdom', 'uk is also United Kingdom';
};

subtest 'code_from_country' => sub {
    is $countries->code_from_country('Australia'),          'au', 'Australia is AU';
    is $countries->code_from_country('United Kingdom'),     'gb', 'United Kingdom is GB';
    is $countries->code_from_country('Russian Federation'), 'ru', 'Russian Federation is RU';
    is $countries->code_from_country('Indonesia'),          'id', 'Indonesia is ID';
};

subtest 'idd_from_code' => sub {
    is $countries->idd_from_code('us'), '1',    'US is idd 1';
    is $countries->idd_from_code('ai'), '1264', 'AI is idd 1264';
    is $countries->idd_from_code('gb'), '44',   'GB is idd 44';
    is $countries->idd_from_code('in'), '91',   'IN is idd 91';
    is $countries->idd_from_code('US'), '1',    'US is idd 1';
    is $countries->idd_from_code('AI'), '1264', 'AI is idd 1264';
    is $countries->idd_from_code('GB'), '44',   'GB is idd 44';
    is $countries->idd_from_code('IN'), '91',   'IN is idd 91';
};

subtest 'code_from_phone' => sub {
    is $countries->code_from_phone('001222694669'),    'us', '001222694669 is from US';
    is $countries->code_from_phone('+1 264 99922211'), 'ai', '+1 264 99922211 is from AI';
    is $countries->code_from_phone('+44 8882220202'),  'gb', '+44 8882220202 is from GB';
};

