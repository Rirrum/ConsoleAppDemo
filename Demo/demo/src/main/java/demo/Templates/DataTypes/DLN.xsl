<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         DLN template, corresponding to FHIR-Converter DLN
         Need to determine if this template should be called
         even when PID.20 doesn't exist/handle HAPI parser
         output with just PID.20 instead of nested DLN.1-3
         
    -->
    
    <!-- <xsl:import href="../Functions/DateTime.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=zdNLdR9Woqso07vIAMZ5BmbCoXkKvgmZIYlUVZ2zwv0"/>
    
    <xsl:template name="DLN">
        <xsl:param name="curr"/>
        <map>
            <string key="value"><xsl:value-of select="$curr/hl7:DLN.1"/></string>
            <map key="type">
                <array key="coding">
                    <map>
                        <string key="code">DL</string>
                    </map>
                </array>
            </map>
            <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:DLN.2"/></string>
            <map key="period">
                <string key="end"><xsl:call-template name="DateTime">
                        <xsl:with-param name="date" select="$curr/hl7:DLN.3"/>
                    </xsl:call-template></string>
            </map>
        </map>
    </xsl:template>
</xsl:stylesheet>