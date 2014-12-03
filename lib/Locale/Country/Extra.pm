package Locale::Country::Extra;
use strict; use warnings;

our $VERSION = '0.03';

use Moose;
use Locale::Country qw();
use Locale::Country::Multilingual {use_io_layer => 1};

sub country_from_code {
    my ($self, $code) = @_;
    die "code is required" if !$code;
    $code = lc $code;

    # we need gb
    $code = 'gb' if $code eq 'uk';

    return $self->_country_codes->{$code};
}

sub code_from_country {
    my ($self, $country) = @_;
    die "country is required" if !$country;

    my %code_countries = reverse %{$self->_country_codes};
    return lc $code_countries{$country};
}

sub idd_from_code {
    my ($self, $code) = @_;
    die "code is required" if !$code;
    $code = lc $code;

    # we need gb
    $code = 'gb' if $code eq 'uk';

    return $self->_idd_codes->{$code};
}

sub code_from_phone {
    my ($self, $number) = @_;
    die "number is required" if !$number;

    $number =~ s/\D//g;    # Remove non-digits
    $number =~ s/^00//;    # Remove the leading '00'.

    if ($number !~ /^(111111|222222|333333|444444|555555|666666|777777|888888|999999|000000)/) {
        my %code_for_idd = reverse %{$self->_idd_codes};
        foreach my $iddcode (sort { $b <=> $a } keys %code_for_idd) {
            if ($number =~ /^$iddcode/) {
                return lc $code_for_idd{$iddcode};
            }
        }
    }

    return '';
}

sub all {
    my $self = shift;
    return values %{$self->_country_codes};
}

sub all_country_codes {
    my $self = shift;
    return keys %{$self->_country_codes};
}

sub localized_code2country {
    my ($self, $country_code, $lang) = @_;
    die "country_code is required" if !$country_code;
    die "lang is required" if !$lang;

    my $lcm = Locale::Country::Multilingual->new();
    return $lcm->code2country($country_code, $lang);
}

has _country_codes => (
    is         => 'ro',
    lazy_build => 1,
);

sub _build__country_codes {
    my $lcm   = Locale::Country::Multilingual->new();
    my @codes = $lcm->all_country_codes();

    my $country_hash = {};
    foreach my $code (@codes) {
        $country_hash->{lc($code)} = $lcm->code2country($code);
    }

    return $country_hash;
}

has '_idd_codes' => (
    is         => 'ro',
    lazy_build => 1,
);

sub _build__idd_codes {
    my $idd_for_codes = {
        1      => "us",
        1242   => "bs",
        1246   => "bb",
        1264   => "ai",
        1268   => "ag",
        1284   => "vg",
        1340   => "vi",
        1345   => "ky",
        1441   => "bm",
        1473   => "gd",
        1649   => "tc",
        1664   => "ms",
        1670   => "mp",
        1758   => "lc",
        1784   => "vc",
        1787   => "pr",
        1767   => "dm",
        1809   => "do",
        1868   => "tt",
        1869   => "kn",
        1876   => "jm",
        20     => "eg",
        21     => "eh",
        212    => "ma",
        213    => "dz",
        216    => "tn",
        218    => "ly",
        220    => "gm",
        221    => "sn",
        222    => "mr",
        223    => "ml",
        224    => "gn",
        225    => "ci",
        226    => "bf",
        227    => "ne",
        228    => "tg",
        229    => "bj",
        230    => "mu",
        231    => "lr",
        232    => "sl",
        233    => "gh",
        234    => "ng",
        235    => "td",
        236    => "cf",
        237    => "cm",
        238    => "cv",
        239    => "st",
        240    => "gq",
        241    => "ga",
        242    => "cg",
        243    => "cd",
        244    => "ao",
        245    => "gw",
        246    => "io",
        248    => "sc",
        249    => "sd",
        250    => "rw",
        251    => "et",
        252    => "so",
        253    => "dj",
        254    => "ke",
        255    => "tz",
        256    => "ug",
        257    => "bi",
        258    => "mz",
        260    => "zm",
        261    => "mg",
        262    => "RE",
        263    => "zw",
        264    => "na",
        265    => "mw",
        266    => "ls",
        267    => "bw",
        268    => "sz",
        269    => "yt",
        27     => "za",
        290    => "sh",
        291    => "er",
        297    => "aw",
        298    => "fo",
        299    => "gl",
        30     => "gr",
        31     => "nl",
        32     => "be",
        33     => "fr",
        34     => "es",
        350    => "gi",
        351    => "pt",
        352    => "lu",
        353    => "ie",
        354    => "is",
        355    => "al",
        356    => "mt",
        357    => "cy",
        358    => "fi",
        359    => "bg",
        36     => "hu",
        370    => "lt",
        371    => "lv",
        372    => "ee",
        373    => "md",
        374    => "am",
        375    => "by",
        376    => "ad",
        377    => "mc",
        378    => "sm",
        379    => "va",
        380    => "ua",
        381    => "rs",
        385    => "hr",
        386    => "si",
        387    => "ba",
        389    => "mk",
        39     => "it",
        40     => "ro",
        417    => "li",
        41     => "ch",
        420    => "cz",
        421    => "sk",
        43     => "at",
        441534 => "je",
        441624 => "im",
        447624 => "im",
        44     => "gb",
        45     => "dk",
        46     => "se",
        47     => "no",
        48     => "pl",
        49     => "de",
        500    => "fk",
        501    => "bz",
        502    => "gt",
        503    => "sv",
        504    => "hn",
        505    => "ni",
        506    => "cr",
        507    => "pa",
        508    => "pm",
        509    => "ht",
        51     => "pe",
        52     => "mx",
        53     => "cu",
        54     => "ar",
        55     => "br",
        56     => "cl",
        57     => "co",
        58     => "ve",
        590    => "gp",
        591    => "bo",
        592    => "gy",
        593    => "ec",
        594    => "gf",
        595    => "py",
        596    => "mq",
        597    => "sr",
        598    => "uy",
        599    => "an",
        60     => "my",
        61     => "au",
        618    => "cx",
        62     => "id",
        63     => "ph",
        64     => "nz",
        649    => "pn",
        65     => "sg",
        66     => "th",
        670    => "tl",
        671    => "gu",
        672    => "aq",
        673    => "bn",
        674    => "nr",
        675    => "pg",
        676    => "to",
        677    => "sb",
        678    => "vu",
        679    => "fj",
        680    => "pw",
        681    => "wf",
        682    => "ck",
        683    => "nu",
        684    => "as",
        685    => "ws",
        686    => "ki",
        687    => "nc",
        688    => "tv",
        689    => "pf",
        690    => "tk",
        691    => "fm",
        692    => "mh",
        7      => "ru",
        7      => "kz",
        81     => "jp",
        82     => "kr",
        84     => "vn",
        850    => "kp",
        852    => "hk",
        853    => "mo",
        855    => "kh",
        856    => "la",
        86     => "cn",
        880    => "bd",
        886    => "tw",
        90     => "tr",
        91     => "in",
        92     => "pk",
        93     => "af",
        94     => "lk",
        95     => "mm",
        960    => "mv",
        961    => "lb",
        962    => "jo",
        963    => "sy",
        964    => "iq",
        965    => "kw",
        966    => "sa",
        967    => "ye",
        968    => "om",
        970    => "ps",
        971    => "ae",
        972    => "il",
        973    => "bh",
        974    => "qa",
        975    => "bt",
        976    => "mn",
        977    => "np",
        98     => "ir",
        992    => "tj",
        993    => "tm",
        994    => "az",
        995    => "ge",
        996    => "kg",
        998    => "uz",
    };

    my %codes = reverse %$idd_for_codes;
    return \%codes;
}

# need to remove
sub staff_system_id {
    my $self       = shift;
    my $staff_name = shift;

    my $staff_ids = {
        admin        => 0,
        jy           => 1,
        piers        => 2,
        clive        => 3,
        joanna       => 4,
        stephany     => 5,
        charisse     => 7,
        olivia       => 8,
        julia        => 9,
        victor       => 10,
        hama         => 13,
        mon          => 14,
        azidin       => 15,
        noreen       => 16,
        balaa        => 17,
        kavitha      => 18,
        rane         => 19,
        ailun        => 20,
        louise       => 21,
        sweemeng     => 23,
        ady          => 24,
        casey        => 25,
        meiying      => 26,
        kahhin       => 27,
        juan         => 28,
        michael      => 29,
        wanfei       => 30,
        juliette     => 31,
        gesa         => 32,
        olga         => 33,
        yngshan      => 34,
        edwin        => 35,
        callum       => 36,
        pathma       => 37,
        geokkheng    => 38,
        dominik      => 39,
        anu          => 40,
        baljit       => 41,
        manqing      => 42,
        thinegan     => 43,
        arif         => 44,
        weichong     => 45,
        calum        => 46,
        ivan         => 47,
        welly        => 48,
        kheyeng      => 49,
        michaelchong => 50,
        karen        => 51,
        putri        => 52,
        shyamala     => 53,
        steven       => 54,
        derek        => 55,
        sokting      => 56,
        tom          => 57,
        meiling      => 58,
        mark         => 59,
        mario        => 60,
        wilson       => 61,
        liuyang      => 62,
        felix        => 63,
        alex         => 64,
        englebert    => 65,
        jamila       => 66,
        chinho       => 67,
        keenlum      => 68,
        hanane       => 69,
        alfiya       => 70,
        ayoama       => 71,
        jeanpaul     => 72,
        omid         => 73,
        yanhong      => 74,
        peyman       => 75,
        mohammad     => 76,
        ehsanjamali  => 77,
        geewai       => 78,
        fairozee     => 79,
        gumilar      => 80,
        navin        => 81,
        sunny        => 82,
        deni         => 83,
        achilles     => 84,
        holger       => 85,
        adhitya      => 86,
        jullian      => 87,
        yancheng     => 88,
        fiona        => 89,
        fauziah      => 90,
        shuwnyuan    => 91,
        azadeh       => 92,
        fuguo        => 93,
        todd         => 94,
        rakshit      => 95,
        jeremy       => 96,
        kaveh        => 97,
        junbon       => 98,
        paul         => 99,
        jennice      => 100,
        matt         => 101,
        peiklooi     => 102,
        sandeep      => 103,
        balvin       => 104,
        isaac        => 105,
        nick         => 106,
        aanchien     => 107,
        luisa        => 108,
        holleh       => 109,
        nantinii     => 110,
        pavel        => 111,
        lola         => 112,
        carel        => 113,
        arun         => 114,
        chris        => 115,
        alex         => 116,
        sandra       => 117,
        milad        => 118,
        carlos       => 119,
        fabrice      => 120,
        trishul      => 121,
        zhenning     => 122,
        manros       => 123,
        arpad        => 124,
        gryphon      => 125,
        trevor       => 126,
        navid        => 127,
        annalyn      => 128,
        rachel       => 129,
        lena         => 130,
        ross         => 131,
        farzad       => 132,
        bijan        => 133,
        swapna       => 134,
        saori        => 135,
        frank        => 136,
        thana        => 137,
        jeff         => 138,
        rizwan       => 139,
        kevin        => 140,
        torsten      => 141,
        andrew       => 142,
        raunak       => 143,
        vladimir     => 144,
        sally        => 145,
        ditesh       => 146,
        mahdi        => 147,
        christravers => 148,
        meitheng     => 149,
        nisa         => 150,
        rakesh       => 151,
        crislin      => 152,
        ashkan       => 153,
    };

    return $staff_ids->{$staff_name};
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Locale::Country::Extra

=head1 VERSION

Version 0.04

=head1 SYNOPSIS

use Locale::Country::Extra;

=head1 DESCRIPTION

=head1 SUBROUTINES

=head2 vanilla_call

    USAGE
    my $sensitivity = vanilla_call($S, $K, $t, $r_q, $mu, $sigma)

    PARAMS
    $S => stock price
    $K => barrier
    $t => time (1 = 1 year)
    $r_q => payout currency interest rate (0.05 = 5%)
    $mu => quanto drift adjustment (0.05 = 5%)
    $sigma => volatility (0.3 = 30%)

=cut

=head1 DEPENDENCIES

=over 4

=item L<Moose>

=item L<Locale::Country>

=item L<Locale::Country::Multilingual>

=back

=head1 SOURCE CODE

L<Github|https://github.com/binary-com/perl-Locale-Country-Extra>

=head1 AUTHOR

binary.com, C<< <perl at binary.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-locale-country-extra at rt.cpan.org>, or through the web
interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Locale-Country-Extra>.
We will be notified, and then you'll automatically be notified of progress on
your bug as we make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Locale::Country::Extra

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Locale-Country-Extra>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Locale-Country-Extra>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Locale-Country-Extra>

=item * Search CPAN

L<http://search.cpan.org/dist/Locale-Country-Extra/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2014 binary.com.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

