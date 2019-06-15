requires 'Locale::Codes', '3.42';
requires 'Locale::Country::Multilingual';

on test => sub {
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'Test::NoWarnings';
};
