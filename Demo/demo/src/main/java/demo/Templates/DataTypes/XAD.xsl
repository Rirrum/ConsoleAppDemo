<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Template for handling addresses, following FHIR-Converter
         DataType/XAD
         
    -->
    
    <!-- <xsl:import href="../Functions/Codes.xsl"/>
    <xsl:import href="../Functions/DateTime.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=zdNLdR9Woqso07vIAMZ5BmbCoXkKvgmZIYlUVZ2zwv0"/>
    
    <xsl:template name="XAD">
        <xsl:param name="curr"/>
        <array key="line">
            <xsl:if test="$curr/hl7:XAD.1/hl7:SAD.1">
                <string><xsl:value-of select="$curr/hl7:XAD.1/hl7:SAD.1"/></string>
            </xsl:if>
            <xsl:if test="$curr/hl7:XAD.1/hl7:SAD.2">
                <string><xsl:value-of select="$curr/hl7:XAD.1/hl7:SAD.2"/></string>
            </xsl:if>
            <xsl:if test="$curr/hl7:XAD.1/hl7:SAD.3">
                <string><xsl:value-of select="$curr/hl7:XAD.1/hl7:SAD.3"/></string>
            </xsl:if>
            <xsl:if test="$curr/hl7:XAD.2">
                <string><xsl:value-of select="$curr/hl7:XAD.2"/></string>
            </xsl:if>
            <xsl:if test="$curr/hl7:XAD.19">
                <string><xsl:value-of select="$curr/hl7:XAD.19"/></string>
            </xsl:if>
        </array>
        <xsl:if test="$curr/hl7:XAD.3">
            <string key="city"><xsl:value-of select="$curr/hl7:XAD.3"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.4">
            <string key="state"><xsl:value-of select="$curr/hl7:XAD.4"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.5">
            <string key="postalCode"><xsl:value-of select="$curr/hl7:XAD.5"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.6">
            <string key="country"><xsl:value-of select="$curr/hl7:XAD.6"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.7='M' or $curr/hl7:XAD.7 = 'SH'">
            <string key="type"><xsl:call-template name="codeInfo">
                    <xsl:with-param name="systemParam" select="'CodeSystem/AddressType'"/>
                    <xsl:with-param name="codeParam" select="$curr/hl7:XAD.7"/>
                    <xsl:with-param name="whichParam" select="'code'"/>
                </xsl:call-template> </string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.7='BA' or $curr/hl7:XAD.7 = 'BI'
            or $curr/hl7:XAD.7='C' or $curr/hl7:XAD.7 = 'B'
            or $curr/hl7:XAD.7='H' or $curr/hl7:XAD.7 = 'O'">
            <string key="use"><xsl:call-template name="codeInfo">
                    <xsl:with-param name="systemParam" select="'CodeSystem/AddressType'"/>
                    <xsl:with-param name="codeParam" select="$curr/hl7:XAD.7"/>
                    <xsl:with-param name="whichParam" select="'code'"/>
                </xsl:call-template> </string>
        </xsl:if>
        <!-- FHIR Converter uses XAD.9.2 & 9;, but this doesn't exist in the parsed XML -->
        <xsl:if test="$curr/hl7:XAD.9/hl7:CWE.2">
            <string key="district"><xsl:value-of select="$curr/hl7:XAD.9/hl7:CWE.2"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.9/hl7:CWE.1 and not($curr/hl7:XAD.9/hl7:CWE.2)">
            <string key="district"><xsl:value-of select="$curr/hl7:XAD.9/hl7:CWE.1"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XAD.12 or $curr/hl7:XAD.13 or $curr/hl7:XAD.14">
            <map key="period">
                <!-- XAD.12 may need to be broken into 2 pieces, FHIR Converter has XAD.12.1
                     as a start time and XAD.12.2 as an end time, but haven't seen both be present at once -->
                <xsl:if test="$curr/hl7:XAD.12">
                    <string key="start"><xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:XAD.12"/>
                        </xsl:call-template></string>
                </xsl:if>
                <xsl:if test="$curr/hl7:XAD.13">
                    <string key="start"><xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:XAD.13"/>
                        </xsl:call-template></string>
                </xsl:if>
                <xsl:if test="$curr/hl7:XAD.14">
                    <string key="end"><xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:XAD.14"/>
                        </xsl:call-template></string>
                </xsl:if>
            </map>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>