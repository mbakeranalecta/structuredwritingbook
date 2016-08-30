<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"  queryBinding="xslt2">
    <pattern>
        <title>Age constraint</title>
        <rule context="person">
            <assert test="age = xs:int(days-from-duration(current-date() - xs:date('1970-12-25')) div 365.25)">Age does not match the given date-of-birth.</assert>
        </rule>
    </pattern>
</schema>
