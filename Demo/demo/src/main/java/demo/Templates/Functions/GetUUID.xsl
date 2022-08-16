<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
     <xsl:output method="text" encoding="UTF-8"/>
     
     <!--
          
          This function is a temporary solution to create guids
          that will pass the FHIR Validator tests. This is not
          production level and should be replaced by a C# assembly
          that will create proper guids that are unique beyond the scope
          of one message
          
     -->
     
     <xsl:template name="GetUUID">
     <xsl:param name="curr"/>
          <xsl:value-of select="concat(generate-id($curr),'06-5e87-6fbc-ad1b-170ab430499f')"/>
     </xsl:template>
</xsl:stylesheet>