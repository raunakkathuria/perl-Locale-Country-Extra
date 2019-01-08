requires 'Locale::Country::Multilingual';

on configure => sub {
    requires 'Locale::Country';
    requires 'Locale::Codes';
}

on test => sub {
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'Test::NoWarnings';
};
