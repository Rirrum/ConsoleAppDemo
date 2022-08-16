<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Following FHIR-Converter DRPeriod DataType
         
    -->
    
    <!-- <xsl:import href="../Functions/DateTime.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=zdNLdR9Woqso07vIAMZ5BmbCoXkKvgmZIYlUVZ2zwv0"/>
    
    <xsl:template name="DRPeriod">
        <xsl:param name="curr"/>
        <!-- may have to consider case when one exists -->
        <xsl:if test="$curr/hl7:DR.1 and $curr/hl7:DR.2">
            <string key="start"><xsl:call-template name="DateTime">
                    <xsl:with-param name="date" select="$curr/hl7:DR.1"/>
                </xsl:call-template></string>
            <string key="end"><xsl:call-template name="DateTime">
                    <xsl:with-param name="date" select="$curr/hl7:DR.2"/>
                </xsl:call-template></string>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>