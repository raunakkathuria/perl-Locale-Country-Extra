requires 'Locale::Country';
requires 'Locale::Country::Multilingual';
requires 'perl', '5.006';

on configure => sub {
    requires 'ExtUtils::MakeMaker';
};

on build => sub {
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'Test::NoWarnings';
};
