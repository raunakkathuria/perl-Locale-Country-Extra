#!/usr/bin/perl
use strict; use warnings;

use lib 'lib';
use Test::More (tests => 6);
use Test::Exception;
use Locale::Country::Extra;

my $countries = Locale::Country::Extra->new();

throws_ok {
    my $c = $countries->country_from_code()
} qr/code is required/, 'country_from_code';

throws_ok {
    my $c = $countries->code_from_country()
} qr/country is required/, 'code_from_country';

throws_ok {
    my $c = $countries->idd_from_code()
} qr/code is required/, 'idd_from_code';

throws_ok {
    my $c = $countries->code_from_phone()
} qr/number is required/, 'code_from_phone';

throws_ok {
    my $c = $countries->localized_code2country()
} qr/country_code is required/, 'localized_code2country 1';

throws_ok {
    my $c = $countries->localized_code2country('in')
} qr/lang is required/, 'localized_code2country 2';

