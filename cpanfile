requires 'Locale::Country';
requires 'Locale::Codes';
requires 'Locale::Country::Multilingual';

on test => sub {
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'Test::NoWarnings';
};
