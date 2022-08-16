<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
  <xsl:output method="text" encoding="UTF-8"/>
  
  <!--
       
       ADT_A01 Message template
       
  -->
  
  <!-- <xsl:import href="Resources/Patient.xsl"/>
  <xsl:import href="Functions/DateTime.xsl"/>
  <xsl:import href="Functions/GetUUID.xsl"/> -->
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Patient/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A46%3A05.0292678Z&amp;sp=%2Fmaps%2FPatient%2Fread&amp;sv=1.0&amp;sig=S-h75SJY0d6IJ6vYO0E8mM1mMzVwNIJJo4w_7ENaaLo"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A46%3A05.0292678Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=FgCG3YV53JIvS430DG3HqCwA-TNZL0kGvRbKh1fN5Nk"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/GetUUID/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A46%3A05.0292678Z&amp;sp=%2Fmaps%2FGetUUID%2Fread&amp;sv=1.0&amp;sig=17AQxGj81Zeo4q6rgGi1tp3DLhkGH0BfCtluxQvYvSo"/>
  
  <xsl:template match="/hl7:ADT_A02">
    <xsl:variable name="fhir">
      <map>
        <string key="resourceType">Bundle</string>
        <string key="type">batch</string>
        <string key="timestamp"><xsl:call-template name="DateTime">
            <xsl:with-param name="date" select="./hl7:MSH/hl7:MSH.7"/>
          </xsl:call-template></string>
        <map key = "identifier">
          <string key="value">
            <xsl:value-of select="./hl7:MSH/hl7:MSH.10"/>
          </string>
        </map>
        <string key="id">
          <xsl:call-template name="GetUUID">
            <xsl:with-param name="curr" select="./hl7:MSH/hl7:MSH.10"/>
          </xsl:call-template></string>
        <array key="entry">
          <xsl:call-template name="Patient"/>
        </array>
      </map>
    </xsl:variable>
    <xsl:value-of select="xml-to-json($fhir, map { 'indent' : true() })"/>
  </xsl:template>
</xsl:stylesheet>